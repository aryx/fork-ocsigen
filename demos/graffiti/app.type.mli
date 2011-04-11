module H :
  sig
    type uri = Uri.uri
    type uris = Uri.uris
    val string_of_uri : uri -> string
    val uri_of_string : string -> uri
    type 'a attrib = 'a XHTML5.M.attrib
    type 'a attribs = 'a XHTML5.M.attribs
    val to_xmlattribs : 'a attrib list -> XML.attrib list
    val a_autocomplete : [< `Off | `On ] -> [> `Autocomplete ] attrib
    val a_async : [< `Async ] -> [> `Async ] attrib
    val a_autofocus : [< `Autofocus ] -> [> `Autofocus ] attrib
    val a_autoplay : [< `Autoplay ] -> [> `Autoplay ] attrib
    val a_challenge : Xhtml5types.text -> [> `Challenge ] attrib
    val a_contenteditable :
      [< `False | `True ] -> [> `Contexteditable ] attrib
    val a_contextmenu : Xhtml5types.idref -> [> `Contextmenu ] attrib
    val a_controls : [< `Controls ] -> [> `Controls ] attrib
    val a_dir : [< `Ltr | `Rtl ] -> [> `Dir ] attrib
    val a_draggable : [< `False | `True ] -> [> `Draggable ] attrib
    val a_form : Xhtml5types.idref -> [> `Form ] attrib
    val a_formaction : uri -> [> `Formaction ] attrib
    val a_formenctype : Xhtml5types.contenttype -> [> `Formenctype ] attrib
    val a_formmethod :
      [< `Delete | `Get | `Post | `Put ] -> [> `Formmethod ] attrib
    val a_formnovalidate :
      [< `Formnovalidate ] -> [> `Formnovalidate ] attrib
    val a_formtarget : Xhtml5types.text -> [> `Formtarget ] attrib
    val a_hidden : [< `Hidden ] -> [> `Hidden ] attrib
    val a_high : Xhtml5types.float_number -> [> `High ] attrib
    val a_icon : uri -> [> `Icon ] attrib
    val a_ismap : [< `Ismap ] -> [> `Ismap ] attrib
    val a_keytype : Xhtml5types.text -> [> `Keytype ] attrib
    val a_list : Xhtml5types.idref -> [> `List ] attrib
    val a_loop : [< `Loop ] -> [> `Loop ] attrib
    val a_low : Xhtml5types.float_number -> [> `High ] attrib
    val a_max : Xhtml5types.float_number -> [> `Max ] attrib
    val a_input_max : Xhtml5types.number -> [> `Max ] attrib
    val a_min : Xhtml5types.float_number -> [> `Min ] attrib
    val a_input_min : Xhtml5types.number -> [> `Min ] attrib
    val a_novalidate : [< `Novalidate ] -> [> `Novalidate ] attrib
    val a_open : [< `Open ] -> [> `Open ] attrib
    val a_optimum : Xhtml5types.float_number -> [> `Optimum ] attrib
    val a_pattern : Xhtml5types.text -> [> `Pattern ] attrib
    val a_placeholder : Xhtml5types.text -> [> `Placeholder ] attrib
    val a_poster : uri -> [> `Poster ] attrib
    val a_preload : [< `Audio | `Metadata | `None ] -> [> `Preload ] attrib
    val a_pubdate : [< `Pubdate ] -> [> `Pubdate ] attrib
    val a_radiogroup : Xhtml5types.text -> [> `Radiogroup ] attrib
    val a_required : [< `Required ] -> [> `Required ] attrib
    val a_reversed : [< `Reversed ] -> [> `Reversed ] attrib
    val a_sandbox :
      [< `AllowForms | `AllowSameOrigin | `AllowScript ] list ->
      [> `Sandbox ] attrib
    val a_spellcheck : [< `False | `True ] -> [> `Spellcheck ] attrib
    val a_scoped : [< `Scoped ] -> [> `Scoped ] attrib
    val a_seamless : [< `Seamless ] -> [> `Seamless ] attrib
    val a_sizes : Xhtml5types.numbers -> [> `Sizes ] attrib
    val a_span : Xhtml5types.number -> [> `Span ] attrib
    val a_srclang : Xhtml5types.nmtoken -> [> `XML_lang ] attrib
    val a_start : Xhtml5types.number -> [> `Start ] attrib
    val a_step : Xhtml5types.float_number -> [> `Step ] attrib
    val a_wrap : [< `Hard | `Soft ] -> [> `Wrap ] attrib
    val a_class : Xhtml5types.nmtokens -> [> `Class ] attrib
    val a_user_data :
      Xhtml5types.nmtoken -> Xhtml5types.text -> [> `User_data ] attrib
    val a_id : Xhtml5types.text -> [> `Id ] attrib
    val a_title : Xhtml5types.text -> [> `Title ] attrib
    val a_xml_lang : Xhtml5types.nmtoken -> [> `XML_lang ] attrib
    val a_onabort : XML.event -> [> `OnAbort ] attrib
    val a_onafterprint : XML.event -> [> `OnAfterPrint ] attrib
    val a_onbeforeprint : XML.event -> [> `OnBeforePrint ] attrib
    val a_onbeforeunload : XML.event -> [> `OnBeforeUnload ] attrib
    val a_onblur : XML.event -> [> `OnBlur ] attrib
    val a_oncanplay : XML.event -> [> `OnCanPlay ] attrib
    val a_oncanplaythrough : XML.event -> [> `OnCanPlayThrough ] attrib
    val a_onchange : XML.event -> [> `OnChange ] attrib
    val a_onclick : XML.event -> [> `OnClick ] attrib
    val a_oncontextmenu : XML.event -> [> `OnContextMenu ] attrib
    val a_ondblclick : XML.event -> [> `OnDblClick ] attrib
    val a_ondrag : XML.event -> [> `OnDrag ] attrib
    val a_ondragend : XML.event -> [> `OnDragEnd ] attrib
    val a_ondragenter : XML.event -> [> `OnDragEnter ] attrib
    val a_ondragleave : XML.event -> [> `OnDragLeave ] attrib
    val a_ondragover : XML.event -> [> `OnDragOver ] attrib
    val a_ondragstart : XML.event -> [> `OnDragStart ] attrib
    val a_ondrop : XML.event -> [> `OnDrop ] attrib
    val a_ondurationchange : XML.event -> [> `OnDurationChange ] attrib
    val a_onemptied : XML.event -> [> `OnEmptied ] attrib
    val a_onended : XML.event -> [> `OnEnded ] attrib
    val a_onerror : XML.event -> [> `OnError ] attrib
    val a_onfocus : XML.event -> [> `OnFocus ] attrib
    val a_onformchange : XML.event -> [> `OnFormChange ] attrib
    val a_onforminput : XML.event -> [> `OnFormInput ] attrib
    val a_onhashchange : XML.event -> [> `OnHashChange ] attrib
    val a_oninput : XML.event -> [> `OnInput ] attrib
    val a_oninvalid : XML.event -> [> `OnInvalid ] attrib
    val a_onmousedown : XML.event -> [> `OnMouseDown ] attrib
    val a_onmouseup : XML.event -> [> `OnMouseUp ] attrib
    val a_onmouseover : XML.event -> [> `OnMouseOver ] attrib
    val a_onmousemove : XML.event -> [> `OnMouseMove ] attrib
    val a_onmouseout : XML.event -> [> `OnMouseOut ] attrib
    val a_onmousewheel : XML.event -> [> `OnMouseWheel ] attrib
    val a_onoffline : XML.event -> [> `OnOffLine ] attrib
    val a_ononline : XML.event -> [> `OnOnLine ] attrib
    val a_onpause : XML.event -> [> `OnPause ] attrib
    val a_onplay : XML.event -> [> `OnPlay ] attrib
    val a_onplaying : XML.event -> [> `OnPlaying ] attrib
    val a_onpagehide : XML.event -> [> `OnPageHide ] attrib
    val a_onpageshow : XML.event -> [> `OnPageShow ] attrib
    val a_onpopstate : XML.event -> [> `OnPopState ] attrib
    val a_onprogress : XML.event -> [> `OnProgress ] attrib
    val a_onratechange : XML.event -> [> `OnRateChange ] attrib
    val a_onreadystatechange : XML.event -> [> `OnReadyStateChange ] attrib
    val a_onredo : XML.event -> [> `OnRedo ] attrib
    val a_onresize : XML.event -> [> `OnResize ] attrib
    val a_onscroll : XML.event -> [> `OnScroll ] attrib
    val a_onseeked : XML.event -> [> `OnSeeked ] attrib
    val a_onseeking : XML.event -> [> `OnSeeking ] attrib
    val a_onselect : XML.event -> [> `OnSelect ] attrib
    val a_onshow : XML.event -> [> `OnShow ] attrib
    val a_onstalled : XML.event -> [> `OnStalled ] attrib
    val a_onstorage : XML.event -> [> `OnStorage ] attrib
    val a_onsubmit : XML.event -> [> `OnSubmit ] attrib
    val a_onsuspend : XML.event -> [> `OnSuspend ] attrib
    val a_ontimeupdate : XML.event -> [> `OnTimeUpdate ] attrib
    val a_onundo : XML.event -> [> `OnUndo ] attrib
    val a_onunload : XML.event -> [> `OnUnload ] attrib
    val a_onvolumechange : XML.event -> [> `OnVolumeChange ] attrib
    val a_onwaiting : XML.event -> [> `OnWaiting ] attrib
    val a_onkeypress : XML.event -> [> `OnKeyPress ] attrib
    val a_onkeydown : XML.event -> [> `OnKeyDown ] attrib
    val a_onkeyup : XML.event -> [> `OnKeyUp ] attrib
    val a_onload : XML.event -> [> `OnLoad ] attrib
    val a_onloadeddata : XML.event -> [> `OnLoadedData ] attrib
    val a_onloadedmetadata : XML.event -> [> `OnLoadedMetaData ] attrib
    val a_onloadstart : XML.event -> [> `OnLoadStart ] attrib
    val a_onmessage : XML.event -> [> `OnMessage ] attrib
    val a_version : Xhtml5types.cdata -> [> `Version ] attrib
    val a_xmlns : [< `W3_org_1999_xhtml ] -> [> `XMLns ] attrib
    val a_manifest : uri -> [> `Manifest ] attrib
    val a_cite : uri -> [> `Cite ] attrib
    val a_xml_space : [< `Preserve ] -> [> `XML_space ] attrib
    val a_accesskey : Xhtml5types.character -> [> `Accesskey ] attrib
    val a_charset : Xhtml5types.charset -> [> `Charset ] attrib
    val a_accept_charset :
      Xhtml5types.charsets -> [> `Accept_charset ] attrib
    val a_accept : Xhtml5types.contenttypes -> [> `Accept ] attrib
    val a_href : uri -> [> `Href ] attrib
    val a_hreflang : Xhtml5types.languagecode -> [> `Hreflang ] attrib
    val a_rel : Xhtml5types.linktypes -> [> `Rel ] attrib
    val a_tabindex : Xhtml5types.number -> [> `Tabindex ] attrib
    val a_mime_type : Xhtml5types.contenttype -> [> `Mime_type ] attrib
    val a_datetime : Xhtml5types.cdata -> [> `Datetime ] attrib
    val a_action : uri -> [> `Action ] attrib
    val a_checked : [< `Checked ] -> [> `Checked ] attrib
    val a_cols : Xhtml5types.number -> [> `Cols ] attrib
    val a_enctype : Xhtml5types.contenttype -> [> `Enctype ] attrib
    val a_for : Xhtml5types.idref -> [> `For ] attrib
    val a_for_list : Xhtml5types.idrefs -> [> `For_List ] attrib
    val a_maxlength : Xhtml5types.number -> [> `Maxlength ] attrib
    val a_method : [< `Delete | `Get | `Post | `Put ] -> [> `Method ] attrib
    val a_multiple : [< `Multiple ] -> [> `Multiple ] attrib
    val a_name : Xhtml5types.text -> [> `Name ] attrib
    val a_rows : Xhtml5types.number -> [> `Rows ] attrib
    val a_selected : [< `Selected ] -> [> `Selected ] attrib
    val a_size : Xhtml5types.number -> [> `Size ] attrib
    val a_src : uri -> [> `Src ] attrib
    val a_input_type :
      [< `Button
       | `Checkbox
       | `Color
       | `Date
       | `Datetime
       | `Datetime_local
       | `Email
       | `File
       | `Hidden
       | `Image
       | `Month
       | `Number
       | `Password
       | `Radio
       | `Range
       | `Reset
       | `Search
       | `Submit
       | `Tel
       | `Text
       | `Time
       | `Url
       | `Week ] ->
      [> `Input_Type ] attrib
    val a_text_value : Xhtml5types.text -> [> `Text_Value ] attrib
    val a_int_value : Xhtml5types.number -> [> `Int_Value ] attrib
    val a_value : Xhtml5types.cdata -> [> `Value ] attrib
    val a_float_value : Xhtml5types.float_number -> [> `Float_Value ] attrib
    val a_disabled : [< `Disabled ] -> [> `Disabled ] attrib
    val a_readonly : [< `Readonly ] -> [> `Readonly ] attrib
    val a_button_type :
      [< `Button | `Reset | `Submit ] -> [> `Button_Type ] attrib
    val a_command_type :
      [< `Checkbox | `Command | `Radio ] -> [> `Command_Type ] attrib
    val a_menu_type : [< `Context | `Toolbar ] -> [> `Menu_Type ] attrib
    val a_label : Xhtml5types.text -> [> `Label ] attrib
    val a_align :
      [< `Char | `Justify | `Left | `Right ] -> [> `Align ] attrib
    val a_axis : Xhtml5types.cdata -> [> `Axis ] attrib
    val a_colspan : Xhtml5types.number -> [> `Colspan ] attrib
    val a_headers : Xhtml5types.idrefs -> [> `Headers ] attrib
    val a_rowspan : Xhtml5types.number -> [> `Rowspan ] attrib
    val a_scope :
      [< `Col | `Colgroup | `Row | `Rowgroup ] -> [> `Scope ] attrib
    val a_summary : Xhtml5types.text -> [> `Summary ] attrib
    val a_border : Xhtml5types.pixels -> [> `Border ] attrib
    val a_cellpadding : Xhtml5types.length -> [> `Cellpadding ] attrib
    val a_cellspacing : Xhtml5types.length -> [> `Cellspacing ] attrib
    val a_datapagesize : Xhtml5types.cdata -> [> `Datapagesize ] attrib
    val a_rules :
      [< `All | `Cols | `Groups | `None | `Rows ] -> [> `Rules ] attrib
    val a_char : Xhtml5types.character -> [> `Char ] attrib
    val a_charoff : Xhtml5types.length -> [> `Charoff ] attrib
    val a_alt : Xhtml5types.text -> [> `Alt ] attrib
    val a_height : Xhtml5types.number -> [> `Height ] attrib
    val a_width : Xhtml5types.number -> [> `Width ] attrib
    type shape = [ `Circle | `Default | `Poly | `Rect ]
    val a_shape : shape -> [> `Shape ] attrib
    val a_coords : Xhtml5types.numbers -> [> `Coords ] attrib
    val a_usemap : Xhtml5types.idref -> [> `Usemap ] attrib
    val a_data : uri -> [> `Data ] attrib
    val a_codetype : Xhtml5types.contenttype -> [> `Codetype ] attrib
    val a_fs_rows : Xhtml5types.multilengths -> [> `FS_Rows ] attrib
    val a_fs_cols : Xhtml5types.multilengths -> [> `FS_Cols ] attrib
    val a_frameborder : [< `One | `Zero ] -> [> `Frameborder ] attrib
    val a_marginheight : Xhtml5types.pixels -> [> `Marginheight ] attrib
    val a_marginwidth : Xhtml5types.pixels -> [> `Marginwidth ] attrib
    val a_scrolling : [< `Auto | `No | `Yes ] -> [> `Scrolling ] attrib
    val a_target : Xhtml5types.frametarget -> [> `Target ] attrib
    val a_content : Xhtml5types.text -> [> `Content ] attrib
    val a_http_equiv : Xhtml5types.text -> [> `Http_equiv ] attrib
    val a_defer : [< `Defer ] -> [> `Defer ] attrib
    val a_media : Xhtml5types.mediadesc -> [> `Media ] attrib
    val a_style : string -> [> `Style_Attr ] attrib
    type 'a elt = 'a XHTML5.M.elt
    type ('a, 'b) nullary = ?a:'a attrib list -> unit -> 'b elt
    type ('a, 'b, 'c) unary = ?a:'a attrib list -> 'b elt -> 'c elt
    type ('a, 'b, 'c, 'd) binary =
        ?a:'a attrib list -> 'b elt -> 'c elt -> 'd elt
    type ('a, 'b, 'c, 'd) tri = 'a elt -> 'b elt -> 'c elt -> 'd elt
    type ('a, 'b, 'c) star = ?a:'a attrib list -> 'b elt list -> 'c elt
    type ('a, 'b, 'c) plus =
        ?a:'a attrib list -> 'b elt -> 'b elt list -> 'c elt
    type html = [ `Html ] elt
    type rt =
        [ `Rpt of [ `Rp ] elt * [ `Rt ] elt * [ `Rp ] elt
        | `Rt of [ `Rt ] elt ]
    type ruby_content = Xhtml5types.phrasing elt list * rt
    type rp = Xhtml5types.common attrib list * Xhtml5types.phrasing elt list
    val html :
      ?a:Xhtml5types.html_attrib attrib list ->
      [< `Head ] elt -> [< `Body ] elt -> [> `Html ] elt
    val head :
      ?a:Xhtml5types.head_attrib attrib list ->
      [< `Title ] elt ->
      Xhtml5types.head_content_fun elt list -> [> Xhtml5types.head ] elt
    val base : ([< Xhtml5types.base_attrib ], [> Xhtml5types.base ]) nullary
    val title :
      (Xhtml5types.title_attrib, [< Xhtml5types.title_content_fun ],
       [> Xhtml5types.title ])
      unary
    val body :
      ([< Xhtml5types.body_attrib ], [< Xhtml5types.body_content_fun ],
       [> Xhtml5types.body ])
      star
    val svg :
      ?xmlns:string ->
      ?a:[< Xhtml5types.svg_attrib ] SVG.M.attrib list ->
      [< Xhtml5types.svg_content ] SVG.M.elt list -> [> Xhtml5types.svg ] elt
    val footer :
      ([< Xhtml5types.common ], [< Xhtml5types.flow5_without_header_footer ],
       [> `Footer ])
      star
    val header :
      ([< Xhtml5types.common ], [< Xhtml5types.flow5_without_header_footer ],
       [> `Header ])
      star
    val section :
      ([< Xhtml5types.section_attrib ], [< Xhtml5types.section_content_fun ],
       [> Xhtml5types.section ])
      star
    val nav :
      ([< Xhtml5types.nav_attrib ], [< Xhtml5types.nav_content_fun ],
       [> Xhtml5types.nav ])
      star
    val h1 :
      ([< Xhtml5types.h1_attrib ], [< Xhtml5types.h1_content_fun ],
       [> Xhtml5types.h1 ])
      star
    val h2 :
      ([< Xhtml5types.h2_attrib ], [< Xhtml5types.h2_content_fun ],
       [> Xhtml5types.h2 ])
      star
    val h3 :
      ([< Xhtml5types.h3_attrib ], [< Xhtml5types.h3_content_fun ],
       [> Xhtml5types.h3 ])
      star
    val h4 :
      ([< Xhtml5types.h4_attrib ], [< Xhtml5types.h4_content_fun ],
       [> Xhtml5types.h4 ])
      star
    val h5 :
      ([< Xhtml5types.h5_attrib ], [< Xhtml5types.h5_content_fun ],
       [> Xhtml5types.h5 ])
      star
    val h6 :
      ([< Xhtml5types.h6_attrib ], [< Xhtml5types.h6_content_fun ],
       [> Xhtml5types.h6 ])
      star
    val hgroup :
      ([< Xhtml5types.hgroup_attrib ], [< Xhtml5types.hgroup_content_fun ],
       [> Xhtml5types.hgroup ])
      plus
    val address :
      ([< Xhtml5types.address_attrib ], [< Xhtml5types.address_content_fun ],
       [> Xhtml5types.address ])
      star
    val article :
      ([< Xhtml5types.article_attrib ], [< Xhtml5types.article_content_fun ],
       [> Xhtml5types.article ])
      star
    val aside :
      ([< Xhtml5types.aside_attrib ], [< Xhtml5types.aside_content_fun ],
       [> Xhtml5types.aside ])
      star
    val p :
      ([< Xhtml5types.p_attrib ], [< Xhtml5types.p_content_fun ],
       [> Xhtml5types.p ])
      star
    val pre :
      ([< Xhtml5types.pre_attrib ], [< Xhtml5types.pre_content_fun ],
       [> Xhtml5types.pre ])
      star
    val blockquote :
      ([< Xhtml5types.blockquote_attrib ],
       [< Xhtml5types.blockquote_content_fun ], [> Xhtml5types.blockquote ])
      star
    val div :
      ([< Xhtml5types.div_attrib ], [< Xhtml5types.div_content_fun ],
       [> Xhtml5types.div ])
      star
    val dl :
      ?a:[< Xhtml5types.common ] attrib list ->
      (([< `Dt ] elt * [< `Dt ] elt list) *
       ([< `Dd ] elt * [< `Dd ] elt list))
      list -> [> `Dl ] elt
    val ol :
      ([< Xhtml5types.ol_attrib ], [< Xhtml5types.ol_content_fun ],
       [> Xhtml5types.ol ])
      star
    val ul :
      ([< Xhtml5types.ul_attrib ], [< Xhtml5types.ul_content_fun ],
       [> Xhtml5types.ul ])
      star
    val dd :
      ([< Xhtml5types.dd_attrib ], [< Xhtml5types.dd_content_fun ],
       [> Xhtml5types.dd ])
      star
    val dt :
      ([< Xhtml5types.dt_attrib ], [< Xhtml5types.dt_content_fun ],
       [> Xhtml5types.dt ])
      star
    val li :
      ([< Xhtml5types.li_attrib ], [< Xhtml5types.li_content_fun ],
       [> Xhtml5types.li ])
      star
    val figcaption :
      ([< Xhtml5types.figcaption_attrib ],
       [< Xhtml5types.figcaption_content_fun ], [> Xhtml5types.figcaption ])
      star
    val figure :
      ?figcaption:[< `Figcaption ] elt ->
      ([< Xhtml5types.common ], [< Xhtml5types.flow5 ], [> `Figure ]) star
    val hr : ([< Xhtml5types.hr_attrib ], [> Xhtml5types.hr ]) nullary
    val rt :
      ?rp:rp * rp ->
      ?a:[< Xhtml5types.common ] attrib list ->
      [< Xhtml5types.phrasing ] elt list -> rt
    val rp :
      ?a:[< Xhtml5types.common ] attrib list ->
      [< Xhtml5types.phrasing ] elt list -> rp
    val ruby :
      ?a:[< Xhtml5types.common ] attrib list ->
      ruby_content -> ruby_content list -> [> `Ruby ] elt
    val b :
      ([< Xhtml5types.b_attrib ], [< Xhtml5types.b_content_fun ],
       [> Xhtml5types.b ])
      star
    val i :
      ([< Xhtml5types.i_attrib ], [< Xhtml5types.i_content_fun ],
       [> Xhtml5types.i ])
      star
    val small :
      ([< Xhtml5types.small_attrib ], [< Xhtml5types.small_content_fun ],
       [> Xhtml5types.small ])
      star
    val sub :
      ([< Xhtml5types.sub_attrib ], [< Xhtml5types.sub_content_fun ],
       [> Xhtml5types.sub ])
      star
    val sup :
      ([< Xhtml5types.sup_attrib ], [< Xhtml5types.sup_content_fun ],
       [> Xhtml5types.sup ])
      star
    val mark :
      ([< Xhtml5types.mark_attrib ], [< Xhtml5types.mark_content_fun ],
       [> Xhtml5types.mark ])
      star
    val wbr : ([< Xhtml5types.wbr_attrib ], [> Xhtml5types.wbr ]) nullary
    val bdo :
      dir:[< `Ltr | `Rtl ] ->
      ([< Xhtml5types.common ], [< Xhtml5types.phrasing ], [> `Bdo ]) star
    val abbr :
      ([< Xhtml5types.abbr_attrib ], [< Xhtml5types.abbr_content_fun ],
       [> Xhtml5types.abbr ])
      star
    val br : ([< Xhtml5types.br_attrib ], [> Xhtml5types.br ]) nullary
    val cite :
      ([< Xhtml5types.cite_attrib ], [< Xhtml5types.cite_content_fun ],
       [> Xhtml5types.cite ])
      star
    val code :
      ([< Xhtml5types.code_attrib ], [< Xhtml5types.code_content_fun ],
       [> Xhtml5types.code ])
      star
    val dfn :
      ([< Xhtml5types.dfn_attrib ], [< Xhtml5types.dfn_content_fun ],
       [> Xhtml5types.dfn ])
      star
    val em :
      ([< Xhtml5types.em_attrib ], [< Xhtml5types.em_content_fun ],
       [> Xhtml5types.em ])
      star
    val kbd :
      ([< Xhtml5types.kbd_attrib ], [< Xhtml5types.kbd_content_fun ],
       [> Xhtml5types.kbd ])
      star
    val q :
      ([< Xhtml5types.q_attrib ], [< Xhtml5types.q_content_fun ],
       [> Xhtml5types.q ])
      star
    val samp :
      ([< Xhtml5types.samp_attrib ], [< Xhtml5types.samp_content_fun ],
       [> Xhtml5types.samp ])
      star
    val span :
      ([< Xhtml5types.span_attrib ], [< Xhtml5types.span_content_fun ],
       [> Xhtml5types.span ])
      star
    val strong :
      ([< Xhtml5types.strong_attrib ], [< Xhtml5types.strong_content_fun ],
       [> Xhtml5types.strong ])
      star
    val time :
      ([< Xhtml5types.time_attrib ], [< Xhtml5types.time_content_fun ],
       [> Xhtml5types.time ])
      star
    val var :
      ([< Xhtml5types.var_attrib ], [< Xhtml5types.var_content_fun ],
       [> Xhtml5types.var ])
      star
    val a : ([< Xhtml5types.a_attrib ], 'a, [> `A of 'a ]) star
    val del : ([< Xhtml5types.del_attrib ], 'a, [> `Del of 'a ]) star
    val ins : ([< Xhtml5types.ins_attrib ], 'a, [> `Ins of 'a ]) star
    val img :
      src:uri ->
      alt:Xhtml5types.text ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Draggable
        | `Height
        | `Hidden
        | `Id
        | `Ismap
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
        | `Width
        | `XML_lang ],
       [> `Img ])
      nullary
    val iframe :
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Draggable
        | `Height
        | `Hidden
        | `Id
        | `Name
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
        | `Sandbox
        | `Seamless
        | `Spellcheck
        | `Src
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `Width
        | `XML_lang ],
       [< `PCDATA ], [> `Iframe ])
      star
    val object_ :
      ?params:[< `Param ] elt list ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Data
        | `Dir
        | `Draggable
        | `Form
        | `Height
        | `Hidden
        | `Id
        | `Mime_type
        | `Name
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
        | `Usemap
        | `User_data
        | `Width
        | `XML_lang ],
       'a, [> `Object of 'a ])
      star
    val param :
      ([< Xhtml5types.param_attrib ], [> Xhtml5types.param ]) nullary
    val embed :
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Draggable
        | `Height
        | `Hidden
        | `Id
        | `Mime_type
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
        | `Src
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `Width
        | `XML_lang ],
       [> `Embed ])
      nullary
    val audio :
      ?srcs:uri * [< `Source ] elt list ->
      ([< `Accesskey
        | `Autoplay
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Controls
        | `Dir
        | `Draggable
        | `Hidden
        | `Id
        | `Loop
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
        | `Preload
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       'a, [> `Audio of 'a ])
      star
    val video :
      ?srcs:uri * [< `Source ] elt list ->
      ([< `Accesskey
        | `Autoplay
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Controls
        | `Dir
        | `Draggable
        | `Height
        | `Hidden
        | `Id
        | `Loop
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
        | `Poster
        | `Preload
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `Width
        | `XML_lang ],
       'a, [> `Video of 'a ])
      star
    val canvas :
      ([< Xhtml5types.canvas_attrib ], 'a, [> `Canvas of 'a ]) star
    val source :
      ([< Xhtml5types.source_attrib ], [> Xhtml5types.source ]) nullary
    val area :
      alt:Xhtml5types.text ->
      ([< `Accesskey
        | `Alt
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Coords
        | `Dir
        | `Draggable
        | `Hidden
        | `Hreflang
        | `Id
        | `Media
        | `Mime_type
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
        | `Rel
        | `Shape
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Target
        | `Title
        | `User_data
        | `XML_lang ],
       [> `Area ])
      nullary
    val map : ([< Xhtml5types.map_attrib ], 'a, [> `A of 'a ]) plus
    val caption :
      ([< Xhtml5types.caption_attrib ], [< Xhtml5types.caption_content_fun ],
       [> Xhtml5types.caption ])
      star
    val table :
      ?caption:[< `Caption ] elt ->
      ?columns:[< `Colgroup ] elt list ->
      ?thead:[< `Thead ] elt ->
      ?tfoot:[< `Tfoot ] elt ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
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
        | `Summary
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       [< `Tr ], [> `Table ])
      plus
    val tablex :
      ?caption:[< `Caption ] elt ->
      ?columns:[< `Colgroup ] elt list ->
      ?thead:[< `Thead ] elt ->
      ?tfoot:[< `Tfoot ] elt ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
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
        | `Summary
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       [< `Tbody ], [> `Table ])
      star
    val colgroup :
      ([< Xhtml5types.colgroup_attrib ],
       [< Xhtml5types.colgroup_content_fun ], [> Xhtml5types.colgroup ])
      star
    val col : ([< Xhtml5types.col_attrib ], [> Xhtml5types.col ]) nullary
    val thead :
      ([< Xhtml5types.thead_attrib ], [< Xhtml5types.thead_content_fun ],
       [> Xhtml5types.thead ])
      star
    val tbody :
      ([< Xhtml5types.tbody_attrib ], [< Xhtml5types.tbody_content_fun ],
       [> Xhtml5types.tbody ])
      star
    val tfoot :
      ([< Xhtml5types.tfoot_attrib ], [< Xhtml5types.tfoot_content_fun ],
       [> Xhtml5types.tfoot ])
      star
    val td :
      ([< Xhtml5types.td_attrib ], [< Xhtml5types.td_content_fun ],
       [> Xhtml5types.td ])
      star
    val th :
      ([< Xhtml5types.th_attrib ], [< Xhtml5types.th_content_fun ],
       [> Xhtml5types.th ])
      star
    val tr :
      ([< Xhtml5types.tr_attrib ], [< Xhtml5types.tr_content_fun ],
       [> Xhtml5types.tr ])
      star
    val form :
      ([< Xhtml5types.form_attrib ], [< Xhtml5types.form_content_fun ],
       [> Xhtml5types.form ])
      plus
    val fieldset :
      ?legend:[ `Legend ] elt ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Disabled
        | `Draggable
        | `Form
        | `Hidden
        | `Id
        | `Name
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
        | `XML_lang ],
       [< Xhtml5types.flow5 ], [> `Fieldset ])
      star
    val legend :
      ([< Xhtml5types.legend_attrib ], [< Xhtml5types.legend_content_fun ],
       [> Xhtml5types.legend ])
      star
    val label :
      ([< Xhtml5types.label_attrib ], [< Xhtml5types.label_content_fun ],
       [> Xhtml5types.label ])
      star
    val input :
      ([< Xhtml5types.input_attrib ], [> Xhtml5types.input ]) nullary
    val button :
      ([< Xhtml5types.button_attrib ], [< Xhtml5types.button_content_fun ],
       [> Xhtml5types.button ])
      star
    val select :
      ([< Xhtml5types.select_attrib ], [< Xhtml5types.select_content_fun ],
       [> Xhtml5types.select ])
      star
    val datalist :
      ?children:[< `Options of [< `Option ] elt list
                 | `Phras of [< Xhtml5types.phrasing ] elt list ] ->
      ([< Xhtml5types.common ], [> `Datalist ]) nullary
    val optgroup :
      label:Xhtml5types.text ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Disabled
        | `Draggable
        | `Hidden
        | `Id
        | `Label
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
        | `XML_lang ],
       [< `Option ], [> `Optgroup ])
      star
    val option :
      ([< Xhtml5types.option_attrib ], [< Xhtml5types.option_content_fun ],
       [> Xhtml5types.selectoption ])
      unary
    val textarea :
      ([< Xhtml5types.textarea_attrib ],
       [< Xhtml5types.textarea_content_fun ], [> Xhtml5types.textarea ])
      unary
    val keygen :
      ([< Xhtml5types.keygen_attrib ], [> Xhtml5types.keygen ]) nullary
    val progress :
      ([< Xhtml5types.progress_attrib ],
       [< Xhtml5types.progress_content_fun ], [> Xhtml5types.progress ])
      star
    val meter :
      ([< Xhtml5types.meter_attrib ], [< Xhtml5types.meter_content_fun ],
       [> Xhtml5types.meter ])
      star
    val output_elt :
      ([< Xhtml5types.output_elt_attrib ],
       [< Xhtml5types.output_elt_content_fun ], [> Xhtml5types.output_elt ])
      star
    val pcdata : string -> [> `PCDATA ] elt
    val entity : string -> [> `PCDATA ] elt
    val space : unit -> [> `PCDATA ] elt
    val cdata : string -> [> `PCDATA ] elt
    val cdata_script : string -> [> `PCDATA ] elt
    val cdata_style : string -> [> `PCDATA ] elt
    val unsafe_data : string -> 'a elt
    val details :
      [< `Summary ] elt ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
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
        | `Open
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       [< Xhtml5types.flow5 ] elt, [> `Details ])
      star
    val summary :
      ([< Xhtml5types.summary_attrib ], [< Xhtml5types.summary_content_fun ],
       [> Xhtml5types.summary ])
      star
    val command :
      label:Xhtml5types.text ->
      ([< `Accesskey
        | `Checked
        | `Class
        | `Command_Type
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Disabled
        | `Draggable
        | `Hidden
        | `Icon
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
        | `Radiogroup
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       [> `Command ])
      nullary
    val menu :
      ?child:[< `Flows of [< Xhtml5types.flow5 ] elt list
              | `Lis of [< `Li of [< Xhtml5types.common ] ] elt list ] ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Draggable
        | `Hidden
        | `Id
        | `Label
        | `Menu_Type
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
        | `XML_lang ],
       [> `Menu ])
      nullary
    val script :
      ([< Xhtml5types.script_attrib ], [< Xhtml5types.script_content_fun ],
       [> Xhtml5types.script ])
      unary
    val noscript :
      ([< Xhtml5types.noscript_attrib ],
       [< Xhtml5types.noscript_content_fun ], [> Xhtml5types.noscript ])
      plus
    val meta : ([< Xhtml5types.meta_attrib ], [> Xhtml5types.meta ]) nullary
    val style :
      ([< Xhtml5types.style_attrib ], [< Xhtml5types.style_content_fun ],
       [> Xhtml5types.style ])
      star
    val link :
      rel:Xhtml5types.linktypes ->
      href:uri ->
      ([< `Accesskey
        | `Class
        | `Contenteditable
        | `Contextmenu
        | `Dir
        | `Draggable
        | `Hidden
        | `Href
        | `Hreflang
        | `Id
        | `Media
        | `Mime_type
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
        | `Rel
        | `Sizes
        | `Spellcheck
        | `Style_Attr
        | `Tabindex
        | `Title
        | `User_data
        | `XML_lang ],
       [> `Link ])
      nullary
    type doctypes =
        [ `Doctype of string
        | `HTML_v03_02
        | `HTML_v04_01
        | `XHTML_01_00
        | `XHTML_01_01
        | `XHTML_05_00 ]
    val doctype : [< doctypes ] -> string
    val version : string
    val standard : uri
    val tot : XML.elt -> 'a elt
    val totl : XML.elt list -> 'a elt list
    val toelt : 'a elt -> XML.elt
    val toeltl : 'a elt list -> XML.elt list
  end
val __eliom__escaped_expr__reserved_name__3 :
  Xhtml5types.div XHTML5.M.elt option ref
val __eliom__escaped_expr__reserved_name__2 :
  (unit, unit, _[> `Nonattached of _[> `Get ] Eliom_services.na_s ],
   [ `WithoutSuffix ], unit, unit, _[> `Registrable ],
   Eliom_output.Text.return)
  Eliom_services.service option ref
val __eliom__escaped_expr__reserved_name__1 :
  Shared.messages Eliom_bus.t option ref
val include_canvas : string -> Xhtml5types.div XHTML5.M.elt -> unit
