val width : int
val height : int
module My_appl :
  sig
    type page = Xhtml5types.body_content XHTML5.M.elt list
    type options = Eliom_output.appl_service_options
    type return = Eliom_services.appl_service
    val send :
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t -> page -> Ocsigen_http_frame.result Lwt.t
    val register :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      service:('a, 'b, [< Eliom_services.internal_service_kind ],
               [< Eliom_services.suff ], 'c, 'd, [ `Registrable ], return)
              Eliom_services.service ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> 'b -> page Lwt.t) -> unit
    val register_service :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?https:bool ->
      ?priority:int ->
      path:Ocsigen_lib.url_path ->
      get_params:('a, [< Eliom_services.suff ] as 'b, 'c)
                 Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> unit -> page Lwt.t) ->
      ('a, unit,
       [> `Attached of
            ([> `Internal of [> `Service ] ], [> `Get ]) Eliom_services.a_s ],
       'b, 'c, unit, [> `Registrable ], return)
      Eliom_services.service
    val register_coservice :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?name:string ->
      ?csrf_safe:bool ->
      ?csrf_state_name:string ->
      ?csrf_scope:Eliom_common.user_scope ->
      ?csrf_secure:bool ->
      ?max_use:int ->
      ?timeout:float ->
      ?https:bool ->
      fallback:(unit, unit,
                [ `Attached of
                    ([ `Internal of [ `Service ] ], [ `Get ])
                    Eliom_services.a_s ],
                [ `WithoutSuffix ], unit, unit,
                [< Eliom_services.registrable ], return)
               Eliom_services.service ->
      get_params:('a, [ `WithoutSuffix ], 'b) Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> unit -> page Lwt.t) ->
      ('a, unit,
       [> `Attached of
            ([> `Internal of [> `Coservice ] ], [> `Get ]) Eliom_services.a_s ],
       [ `WithoutSuffix ], 'b, unit, [> `Registrable ], return)
      Eliom_services.service
    val register_coservice' :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?name:string ->
      ?csrf_safe:bool ->
      ?csrf_state_name:string ->
      ?csrf_scope:Eliom_common.user_scope ->
      ?csrf_secure:bool ->
      ?max_use:int ->
      ?timeout:float ->
      ?https:bool ->
      get_params:('a, [ `WithoutSuffix ], 'b) Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> unit -> page Lwt.t) ->
      ('a, unit, [> `Nonattached of [> `Get ] Eliom_services.na_s ],
       [ `WithoutSuffix ], 'b, unit, [> `Registrable ], return)
      Eliom_services.service
    val register_post_service :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?https:bool ->
      ?priority:int ->
      fallback:('a, unit,
                [ `Attached of
                    ([ `Internal of [ `Coservice | `Service ] ], [ `Get ])
                    Eliom_services.a_s ],
                [< Eliom_services.suff ] as 'b, 'c, unit, [< `Registrable ],
                'd)
               Eliom_services.service ->
      post_params:('e, [ `WithoutSuffix ], 'f) Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> 'e -> page Lwt.t) ->
      ('a, 'e,
       [> `Attached of
            ([> `Internal of [ `Coservice | `Service ] ], [> `Post ])
            Eliom_services.a_s ],
       'b, 'c, 'f, [> `Registrable ], return)
      Eliom_services.service
    val register_post_coservice :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?name:string ->
      ?csrf_safe:bool ->
      ?csrf_state_name:string ->
      ?csrf_scope:Eliom_common.user_scope ->
      ?csrf_secure:bool ->
      ?max_use:int ->
      ?timeout:float ->
      ?https:bool ->
      fallback:('a, unit,
                [ `Attached of
                    ([ `Internal of [< `Coservice | `Service ] ], [ `Get ])
                    Eliom_services.a_s ],
                [< Eliom_services.suff ] as 'b, 'c, unit, [< `Registrable ],
                return)
               Eliom_services.service ->
      post_params:('d, [ `WithoutSuffix ], 'e) Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      ('a -> 'd -> page Lwt.t) ->
      ('a, 'd,
       [> `Attached of
            ([> `Internal of [> `Coservice ] ], [> `Post ])
            Eliom_services.a_s ],
       'b, 'c, 'e, [> `Registrable ], return)
      Eliom_services.service
    val register_post_coservice' :
      ?scope:Eliom_common.scope ->
      ?options:options ->
      ?charset:string ->
      ?code:int ->
      ?content_type:string ->
      ?headers:Http_headers.t ->
      ?state_name:string ->
      ?secure_session:bool ->
      ?name:string ->
      ?csrf_safe:bool ->
      ?csrf_state_name:string ->
      ?csrf_scope:Eliom_common.user_scope ->
      ?csrf_secure:bool ->
      ?max_use:int ->
      ?timeout:float ->
      ?keep_get_na_params:bool ->
      ?https:bool ->
      post_params:('a, [ `WithoutSuffix ], 'b) Eliom_parameters.params_type ->
      ?error_handler:((string * exn) list -> page Lwt.t) ->
      (unit -> 'a -> page Lwt.t) ->
      (unit, 'a, [> `Nonattached of [> `Post ] Eliom_services.na_s ],
       [ `WithoutSuffix ], unit, 'b, [> `Registrable ], return)
      Eliom_services.service
    val make_string_uri :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, unit,
               [< Eliom_services.registrable ], 'c)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set -> 'a -> string
    val make_uri :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, unit,
               [< Eliom_services.registrable ], 'c)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set -> 'a -> Xhtml5types.uri
    val make_uri_components :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, unit,
               [< Eliom_services.registrable ], 'c)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      'a -> string * (string * string) list * string option
    val make_post_uri_components :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      service:('a, 'b, [< Eliom_services.post_service_kind ],
               [< Eliom_services.suff ], 'c, 'd,
               [< Eliom_services.registrable ], 'e)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?keep_get_na_params:bool ->
      'a ->
      'b ->
      string * (string * string) list * string option *
      (string * string) list
    val make_proto_prefix :
      ?hostname:string ->
      ?port:int -> sp:Eliom_common.server_params option -> bool -> string
    val a :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      ?a:Xhtml5types.a_attrib XHTML5.M.attrib list ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, 'c,
               [< Eliom_services.registrable ], 'd)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?no_appl:bool ->
      'e XHTML5.M.elt list -> 'a -> [> 'e Xhtml5types.a ] XHTML5.M.elt
    val css_link :
      ?a:Xhtml5types.link_attrib XHTML5.M.attrib list ->
      uri:Xhtml5types.uri -> unit -> [> Xhtml5types.link ] XHTML5.M.elt
    val js_script :
      ?a:Xhtml5types.script_attrib XHTML5.M.attrib list ->
      uri:Xhtml5types.uri -> unit -> [> Xhtml5types.script ] XHTML5.M.elt
    val get_form :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      ?a:Xhtml5types.form_attrib XHTML5.M.attrib list ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, 'c,
               [< Eliom_services.registrable ], 'd)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?no_appl:bool ->
      ('b -> Xhtml5types.form_content XHTML5.M.elt list) ->
      [> Xhtml5types.form ] XHTML5.M.elt
    val lwt_get_form :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      ?a:Xhtml5types.form_attrib XHTML5.M.attrib list ->
      service:('a, unit, [< Eliom_services.get_service_kind ],
               [< Eliom_services.suff ], 'b, 'c,
               [< Eliom_services.registrable ], 'd)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?no_appl:bool ->
      ('b -> Xhtml5types.form_content XHTML5.M.elt list Lwt.t) ->
      [> Xhtml5types.form ] XHTML5.M.elt Lwt.t
    val post_form :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      ?a:Xhtml5types.form_attrib XHTML5.M.attrib list ->
      service:('a, 'b, [< Eliom_services.post_service_kind ],
               [< Eliom_services.suff ], 'c, 'd,
               [< Eliom_services.registrable ], 'e)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?keep_get_na_params:bool ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?no_appl:bool ->
      ('d -> Xhtml5types.form_content XHTML5.M.elt list) ->
      'a -> [> Xhtml5types.form ] XHTML5.M.elt
    val lwt_post_form :
      ?absolute:bool ->
      ?absolute_path:bool ->
      ?https:bool ->
      ?a:Xhtml5types.form_attrib XHTML5.M.attrib list ->
      service:('a, 'b, [< Eliom_services.post_service_kind ],
               [< Eliom_services.suff ], 'c, 'd,
               [< Eliom_services.registrable ], 'e)
              Eliom_services.service ->
      ?hostname:string ->
      ?port:int ->
      ?fragment:string ->
      ?keep_nl_params:[ `All | `None | `Persistent ] ->
      ?keep_get_na_params:bool ->
      ?nl_params:Eliom_parameters.nl_params_set ->
      ?no_appl:bool ->
      ('d -> Xhtml5types.form_content XHTML5.M.elt list Lwt.t) ->
      'a -> [> Xhtml5types.form ] XHTML5.M.elt Lwt.t
    type basic_input_type = [ `Hidden | `Password | `Submit | `Text ]
    val int_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< int Eliom_parameters.setoneradio ] Eliom_parameters.param_name ->
      ?value:int -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int32_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< int32 Eliom_parameters.setoneradio ]
            Eliom_parameters.param_name ->
      ?value:int32 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int64_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< int64 Eliom_parameters.setoneradio ]
            Eliom_parameters.param_name ->
      ?value:int64 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val float_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< float Eliom_parameters.setoneradio ]
            Eliom_parameters.param_name ->
      ?value:float -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val string_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< string Eliom_parameters.setoneradio ]
            Eliom_parameters.param_name ->
      ?value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val user_type_input :
      ('a -> string) ->
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< basic_input_type ] ->
      ?name:[< 'a Eliom_parameters.setoneradio ] Eliom_parameters.param_name ->
      ?value:'a -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val raw_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      input_type:[< `Button | `Hidden | `Password | `Reset | `Submit | `Text ] ->
      ?name:string ->
      ?value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val file_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< Ocsigen_lib.file_info Eliom_parameters.setoneradio ]
           Eliom_parameters.param_name ->
      unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< Eliom_parameters.coordinates Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< (int * Eliom_parameters.coordinates) Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:int ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int32_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< (int32 * Eliom_parameters.coordinates)
              Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:int32 ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int64_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< (int64 * Eliom_parameters.coordinates)
              Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:int64 ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val float_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< (float * Eliom_parameters.coordinates)
              Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:float ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val string_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< (string * Eliom_parameters.coordinates)
              Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:string ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val user_type_image_input :
      ('a -> string) ->
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:[< ('a * Eliom_parameters.coordinates) Eliom_parameters.oneradio ]
           Eliom_parameters.param_name ->
      value:'a ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val raw_image_input :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      name:string ->
      value:string ->
      ?src:Xhtml5types.uri -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val bool_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `One of bool ] Eliom_parameters.param_name ->
      unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of int ] Eliom_parameters.param_name ->
      value:int -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int32_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of int32 ] Eliom_parameters.param_name ->
      value:int32 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int64_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of int64 ] Eliom_parameters.param_name ->
      value:int64 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val float_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of float ] Eliom_parameters.param_name ->
      value:float -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val string_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of string ] Eliom_parameters.param_name ->
      value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val user_type_checkbox :
      ('a -> string) ->
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Set of 'a ] Eliom_parameters.param_name ->
      value:'a -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val raw_checkbox :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:string ->
      value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val string_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of string ] Eliom_parameters.param_name ->
      value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of int ] Eliom_parameters.param_name ->
      value:int -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int32_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of int32 ] Eliom_parameters.param_name ->
      value:int32 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val int64_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of int64 ] Eliom_parameters.param_name ->
      value:int64 -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val float_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of float ] Eliom_parameters.param_name ->
      value:float -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val user_type_radio :
      ('a -> string) ->
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:[ `Radio of 'a ] Eliom_parameters.param_name ->
      value:'a -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    val raw_radio :
      ?a:Xhtml5types.input_attrib XHTML5.M.attrib list ->
      ?checked:bool ->
      name:string ->
      value:string -> unit -> [> Xhtml5types.input ] XHTML5.M.elt
    type button_type = [ `Button | `Reset | `Submit ]
    val string_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< string Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:string ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val int_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< int Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:int ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val int32_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< int32 Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:int32 ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val int64_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< int64 Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:int64 ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val float_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< float Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:float ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val user_type_button :
      ('a -> string) ->
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      name:[< 'a Eliom_parameters.setone ] Eliom_parameters.param_name ->
      value:'a ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val raw_button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      button_type:[< button_type ] ->
      name:string ->
      value:string ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val button :
      ?a:Xhtml5types.button_attrib XHTML5.M.attrib list ->
      button_type:[< button_type ] ->
      Xhtml5types.button_content XHTML5.M.elt list ->
      [> Xhtml5types.button ] XHTML5.M.elt
    val textarea :
      ?a:Xhtml5types.textarea_attrib XHTML5.M.attrib list ->
      name:[< string Eliom_parameters.setoneradio ]
           Eliom_parameters.param_name ->
      ?value:string ->
      rows:int -> cols:int -> unit -> [> Xhtml5types.textarea ] XHTML5.M.elt
    val raw_textarea :
      ?a:Xhtml5types.textarea_attrib XHTML5.M.attrib list ->
      name:string ->
      ?value:string ->
      rows:int -> cols:int -> unit -> [> Xhtml5types.textarea ] XHTML5.M.elt
    type 'a soption =
        Xhtml5types.option_attrib XHTML5.M.attrib list * 'a *
        Xhtml5types.pcdata XHTML5.M.elt option * bool
    type 'a select_opt =
        Optgroup of
          [ `Accesskey
          | `Class
          | `Contenteditable
          | `Contextmenu
          | `Dir
          | `Disabled
          | `Draggable
          | `Hidden
          | `Id
          | `OnAbort
          | `OnBlur
          | `OnCanPlay
          | `OnCanPlayThrough
          | `OnChange
          | `OnClick
          | `OnContextMenu
          | `OnDblClick
          | `OnDrag
          | `OnDragEnd
          | `OnDragEnter
          | `OnDragLeave
          | `OnDragOver
          | `OnDragStart
          | `OnDrop
          | `OnDurationChange
          | `OnEmptied
          | `OnEnded
          | `OnError
          | `OnFocus
          | `OnFormChange
          | `OnFormInput
          | `OnInput
          | `OnInvalid
          | `OnKeyDown
          | `OnKeyPress
          | `OnKeyUp
          | `OnLoad
          | `OnLoadStart
          | `OnLoadedData
          | `OnLoadedMetaData
          | `OnMouseDown
          | `OnMouseMove
          | `OnMouseOut
          | `OnMouseOver
          | `OnMouseUp
          | `OnMouseWheel
          | `OnPause
          | `OnPlay
          | `OnPlaying
          | `OnProgress
          | `OnRateChange
          | `OnReadyStateChange
          | `OnScroll
          | `OnSeeked
          | `OnSeeking
          | `OnSelect
          | `OnShow
          | `OnStalled
          | `OnSubmit
          | `OnSuspend
          | `OnTimeUpdate
          | `OnVolumeChange
          | `OnWaiting
          | `Spellcheck
          | `Style_Attr
          | `Tabindex
          | `Title
          | `User_data
          | `XML_lang ] XHTML5.M.attrib list * string * 'a soption *
          'a soption list
      | Option of 'a soption
    val int_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of int ] Eliom_parameters.param_name ->
      int select_opt ->
      int select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val int32_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of int32 ] Eliom_parameters.param_name ->
      int32 select_opt ->
      int32 select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val int64_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of int64 ] Eliom_parameters.param_name ->
      int64 select_opt ->
      int64 select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val float_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of float ] Eliom_parameters.param_name ->
      float select_opt ->
      float select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val string_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of string ] Eliom_parameters.param_name ->
      string select_opt ->
      string select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val user_type_select :
      ('a -> string) ->
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `One of 'a ] Eliom_parameters.param_name ->
      'a select_opt ->
      'a select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val raw_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:string ->
      string select_opt ->
      string select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val int_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of int ] Eliom_parameters.param_name ->
      int select_opt ->
      int select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val int32_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of int32 ] Eliom_parameters.param_name ->
      int32 select_opt ->
      int32 select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val int64_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of int64 ] Eliom_parameters.param_name ->
      int64 select_opt ->
      int64 select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val float_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of float ] Eliom_parameters.param_name ->
      float select_opt ->
      float select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val string_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of string ] Eliom_parameters.param_name ->
      string select_opt ->
      string select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val user_type_multiple_select :
      ('a -> string) ->
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:[< `Set of 'a ] Eliom_parameters.param_name ->
      'a select_opt ->
      'a select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val raw_multiple_select :
      ?a:Xhtml5types.select_attrib XHTML5.M.attrib list ->
      name:string ->
      string select_opt ->
      string select_opt list -> [> Xhtml5types.select ] XHTML5.M.elt
    val application_name : string
  end
val main_service :
  (unit, unit,
   [> `Attached of
        ([> `Internal of [> `Service ] ], [> `Get ]) Eliom_services.a_s ],
   [ `WithoutSuffix ], unit, unit, [> `Registrable ], My_appl.return)
  Eliom_services.service
