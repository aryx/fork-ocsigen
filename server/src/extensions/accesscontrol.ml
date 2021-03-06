(* Ocsigen
 * http://www.ocsigen.org
 * Module accesscontrol.ml
 * Copyright (C) 2007 Vincent Balat, St�phane Glondu
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, with linking exception;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *)

(** Filtering requests in the configuration file *)

(*

Then load it dynamically from Ocsigen's config file:
   <extension module=".../accesscontrol.cmo"/>

*)

open Ocsigen_pervasives

open Printf
open Lwt
open Ocsigen_extensions
open Simplexmlparser
open Ocsigen_http_frame



(*****************************************************************************)
(* Parsing a condition *)

let rec parse_condition = function

    | Element ("ip", ["value", s], []) ->
        let ip_with_mask =
          try
            Ip_address.parse s
          with Failure _ ->
            badconfig "Bad ip/netmask [%s] in <ip> condition" s
        in
        (fun ri ->
           let r = 
             Ip_address.match_ip ip_with_mask 
               (Lazy.force ri.ri_remote_ip_parsed) 
           in
           if r then
             Ocsigen_messages.debug2 (sprintf "--Access control (ip): %s matches %s" ri.ri_remote_ip s)
           else
             Ocsigen_messages.debug2 (sprintf "--Access control (ip): %s does not match %s" ri.ri_remote_ip s);
           r)
    | Element ("ip" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("port", ["value", s], []) ->
        let port =
          try
            int_of_string s
          with Failure _ ->
            badconfig "Bad port [%s] in <port> condition" s
        in
        (fun ri ->
           let r = ri.ri_server_port = port in
           if r then
             Ocsigen_messages.debug2
               (sprintf "--Access control (port): %d accepted" port)
           else
             Ocsigen_messages.debug2
               (sprintf "--Access control (port): %d not accepted (%d expected)" ri.ri_server_port port);
           r)
    | Element ("port" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("ssl", [], []) ->
        (fun ri ->
           let r = ri.ri_ssl in
           if r then
             Ocsigen_messages.debug2 "--Access control (ssl): accepted"
           else
             Ocsigen_messages.debug2 "--Access control (ssl): not accepted";
           r)
    | Element ("ssl" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("header", ["name", name; "regexp", reg], []) ->
        let regexp =
          try
            Netstring_pcre.regexp ("^"^reg^"$")
          with Failure _ ->
            badconfig "Bad regular expression [%s] in <header> condition" reg
        in
        (fun ri ->
           let r =
             List.exists
               (fun a ->
                  let r = Netstring_pcre.string_match regexp a 0 <> None in
                  if r then Ocsigen_messages.debug2 (sprintf "--Access control (header): header %s matches \"%s\"" name reg);
                  r)
               (Http_headers.find_all
                  (Http_headers.name name)
                  ri.ri_http_frame.Ocsigen_http_frame.frame_header.Ocsigen_http_frame.Http_header.headers)
           in
           if not r then Ocsigen_messages.debug2 (sprintf "--Access control (header): header %s does not match \"%s\"" name reg);
           r)
    | Element ("header" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("method", ["value", s], []) ->
        let meth =
          try
            Framepp.method_of_string s
          with Failure _ ->
            badconfig "Bad method [%s] in <method> condition" s
        in
        (fun ri ->
           let r = meth = ri.ri_method in
           if r then Ocsigen_messages.debug
             (fun () -> sprintf "--Access control (method): %s matches %s" (Framepp.string_of_method ri.ri_method) s)
           else Ocsigen_messages.debug
             (fun () -> sprintf "--Access control (method): %s does not match %s" (Framepp.string_of_method ri.ri_method) s);
           r)
    | Element ("method" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("protocol", ["value", s], []) ->
        let pr =
          try
            Framepp.proto_of_string s
          with Failure _ ->
            badconfig "Bad protocol [%s] in <protocol> condition" s
        in
        (fun ri ->
           let r = pr = ri.ri_protocol in
           if r then Ocsigen_messages.debug
             (fun () -> sprintf "--Access control (protocol): %s matches %s" (Framepp.string_of_proto ri.ri_protocol) s)
           else Ocsigen_messages.debug
             (fun () -> sprintf "--Access control (protocol): %s does not match %s" (Framepp.string_of_proto ri.ri_protocol) s);
           r)
    | Element ("protocol" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("path", ["regexp", s], []) ->
        let regexp =
          try
            Netstring_pcre.regexp ("^"^s^"$")
          with Failure _ ->
            badconfig "Bad regular expression [%s] in <path> condition" s
        in
        (fun ri ->
           let r =
             Netstring_pcre.string_match
               regexp ri.ri_sub_path_string 0 <> None
           in
           if r then Ocsigen_messages.debug
             (fun () -> sprintf "--Access control (path): \"%s\" matches \"%s\"" ri.ri_sub_path_string s)
           else Ocsigen_messages.debug
               (fun () -> sprintf "--Access control (path): \"%s\" does not match \"%s\"" ri.ri_sub_path_string s);
           r)
    | Element ("path" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("and", [], sub) ->
        let sub = List.map parse_condition sub in
        (fun ri -> List.for_all (fun cond -> cond ri) sub)
    | Element ("and" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("or", [], sub) ->
        let sub = List.map parse_condition sub in
        (fun ri -> List.exists (fun cond -> cond ri) sub)
    | Element ("or" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | Element ("not", [], [sub]) ->
        let sub = parse_condition sub in
        (fun ri -> not (sub ri))
    | Element ("not" as s, _, _) -> badconfig "Bad syntax for tag %s" s

    | _ ->
        badconfig "Bad syntax for condition"


(*****************************************************************************)
(* Parsing filters *)

let comma_space_regexp = Netstring_pcre.regexp "\ *,\ *"

let parse_config parse_fun = function

  | Element ("if", [], sub) ->
      let (condition, sub) = match sub with
        | cond::q -> (parse_condition cond, q)
        | _ -> badconfig "Bad condition in <if>"
      in
      let (ithen, sub) = match sub with
          | Element("then", [], ithen)::q -> (parse_fun ithen, q)
          | _ -> badconfig "Bad <then> branch in <if>"
      in
      let (ielse, sub) = match sub with
          | Element ("else", [], ielse)::([] as q) -> (parse_fun ielse, q)
          | [] -> (parse_fun [], [])
          | _ -> badconfig "Bad <else> branch in <if>"
      in
      (function
        | Ocsigen_extensions.Req_found (ri, _)
        | Ocsigen_extensions.Req_not_found (_, ri) ->
            Lwt.return
              (if condition ri.request_info then begin
                 Ocsigen_messages.debug2 "--Access control: => going into <then> branch";
                 Ocsigen_extensions.Ext_sub_result ithen
               end
               else begin
                 Ocsigen_messages.debug2 "--Access control: => going into <else> branch, if any";
                 Ocsigen_extensions.Ext_sub_result ielse
               end))
  | Element ("if" as s, _, _) -> badconfig "Bad syntax for tag %s" s


  | Element ("notfound", [], []) ->
      (fun rs ->
         Ocsigen_messages.debug2 "--Access control: taking in charge 404";
         Lwt.return (Ocsigen_extensions.Ext_stop_all
                       (Ocsigen_cookies.Cookies.empty, 404)))
  | Element ("notfound" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("nextsite", [], []) ->
      (function
         | Ocsigen_extensions.Req_found (_, r) ->
             Lwt.return (Ocsigen_extensions.Ext_found_stop 
                           (fun () -> Lwt.return r))
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             Lwt.return (Ocsigen_extensions.Ext_stop_site 
                           (Ocsigen_cookies.Cookies.empty, 404)))

  | Element ("nexthost", [], []) ->
      (function
         | Ocsigen_extensions.Req_found (_, r) ->
             Lwt.return (Ocsigen_extensions.Ext_found_stop
                           (fun () -> Lwt.return r))
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             Lwt.return (Ocsigen_extensions.Ext_stop_host
                           (Ocsigen_cookies.Cookies.empty, 404)))
  | Element ("nextsite" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("stop", [], []) ->
      (function
         | Ocsigen_extensions.Req_found (_, r) ->
             Lwt.return (Ocsigen_extensions.Ext_found_stop
                           (fun () -> Lwt.return r))
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             Lwt.return (Ocsigen_extensions.Ext_stop_all
                           (Ocsigen_cookies.Cookies.empty, 404)))
  | Element ("stop" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("forbidden", [], []) ->
      (fun rs ->
         Ocsigen_messages.debug2 "--Access control: taking in charge 403";
         Lwt.return (Ocsigen_extensions.Ext_stop_all
                       (Ocsigen_cookies.Cookies.empty, 403)))
  | Element ("forbidden" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("iffound", [], sub) ->
      let ext = parse_fun sub in
      (function
         | Ocsigen_extensions.Req_found (_, _) ->
             Lwt.return (Ext_sub_result ext)
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             Lwt.return (Ocsigen_extensions.Ext_next err))
  | Element ("iffound" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("ifnotfound", [], sub) ->
      let ext = parse_fun sub in
      (function
         | Ocsigen_extensions.Req_found (_, r) ->
             Lwt.return (Ocsigen_extensions.Ext_found
                           (fun () -> Lwt.return r))
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             Lwt.return (Ext_sub_result ext))
  | Element ("ifnotfound", [("code", s)], sub) ->
      let ext = parse_fun sub in
      let r = Netstring_pcre.regexp ("^"^s^"$") in
      (function
         | Ocsigen_extensions.Req_found (_, r) ->
             Lwt.return (Ocsigen_extensions.Ext_found
                           (fun () -> Lwt.return r))
         | Ocsigen_extensions.Req_not_found (err, ri) ->
             if Netstring_pcre.string_match r (string_of_int err) 0 <> None then
               Lwt.return (Ext_sub_result ext)
             else
               Lwt.return (Ocsigen_extensions.Ext_next err))
  | Element ("ifnotfound" as s, _, _) -> badconfig "Bad syntax for tag %s" s

  | Element ("allow-forward-for", param, _) ->
    (function
      | Ocsigen_extensions.Req_found (request, {res_code = code} )
      | Ocsigen_extensions.Req_not_found (code, request) ->
	Ocsigen_messages.debug2 "--Access control: allowed proxy";
	let request =
	  try
	    let header = Http_headers.find Http_headers.x_forwarded_for
	      request.request_info.ri_http_frame.frame_header.Http_header.headers in
	    match Netstring_pcre.split comma_space_regexp header with
	      | []
	      | [_] ->
		Ocsigen_messages.debug2 ("--Access control: malformed X-Forwarded-For field: "^header);
		request
	      | original_ip::proxies ->
		let last_proxy = List.last proxies in
		let proxy_ip = fst (Ip_address.parse last_proxy) in
		let equal_ip = proxy_ip = Lazy.force request.request_info.ri_remote_ip_parsed in
		let need_equal_ip =
		  match param with
		    | [] -> false
		    | ["check-equal-ip",b] ->
		      ( try bool_of_string b
			with Invalid_argument _ ->
			  badconfig "Bad syntax for argument of tag allow-forward-for" )
		    | _ -> badconfig "Bad syntax for argument of tag allow-forward-for"
		in
		if equal_ip or (not need_equal_ip)
		then
		  { request with request_info =
		      { request.request_info with
			ri_remote_ip = original_ip;
			ri_remote_ip_parsed = lazy (fst (Ip_address.parse original_ip));
			ri_forward_ip = proxies; } }
		else (* the announced ip of the proxy is not its real ip *)
		  ( Ocsigen_messages.warning (Printf.sprintf "--Access control: X-Forwarded-For: host ip ( %s ) does not match the header ( %s )" request.request_info.ri_remote_ip header );
		    request )
	  with
	    | Not_found -> request
	in
        Lwt.return
	  (Ocsigen_extensions.Ext_continue_with
	     ( request,
	       Ocsigen_cookies.Cookies.empty,
	       code )))

  | Element ("allow-forward-proto", _, _) ->
    (function
      | Ocsigen_extensions.Req_found (request, {res_code = code} )
      | Ocsigen_extensions.Req_not_found (code, request) ->
	Ocsigen_messages.debug2 "--Access control: allowed proxy for ssl";
	let request =
	  try
	    let header = Http_headers.find Http_headers.x_forwarded_proto
	      request.request_info.ri_http_frame.frame_header.Http_header.headers in
	    match String.lowercase header with
	      | "http" ->
		{ request with request_info =
		    { request.request_info with
		      ri_ssl = false; } }
	      | "https" ->
		{ request with request_info =
		    { request.request_info with
		      ri_ssl = true; } }
	      | _ ->
		Ocsigen_messages.debug2 ("--Access control: malformed X-Forwarded-Proto field: "^header);
		request
	  with
	    | Not_found -> request
	in
        Lwt.return
	  (Ocsigen_extensions.Ext_continue_with
	     ( request,
	       Ocsigen_cookies.Cookies.empty,
	       code )))

  | Element (t, _, _) -> raise (Bad_config_tag_for_extension t)
  | _ -> badconfig "(accesscontrol extension) Bad data"




(*****************************************************************************)
(** Registration of the extension *)
let () = register_extension
  ~name:"accesscontrol"
  ~fun_site:(fun _ _ _ _ -> parse_config)
  ~user_fun_site:(fun _ _ _ _ _ -> parse_config)
  ()
