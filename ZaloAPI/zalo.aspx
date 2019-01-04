<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zalo.aspx.cs" Inherits="ZaloAPI.zalo" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>API Zalo</title>
    <meta charset="UTF-8">
    <link href="public/css/css.css" rel="stylesheet" />
    <style>
        .anhdaidien{
            width:65px;
            border-radius: 50%;
            margin-right:10px;
            border: 3px solid #1aa5f6;
        }
        .hinhthe{
            width:50px;
            border-radius: 50%;
        }
        #danhsachban{
            padding: 0;
            margin: 0;
            list-style-type: none;
            height: 600px;
            overflow: auto;
        }
        #khungtinnhan{
            height:600px;
            position: relative;
            padding: 0px 0px 0px 5px;
        }
        #danhsachban li{
            padding: 8px;
            display: inline-table;
            width: 100%;
            float: left;
            
        }
        #danhsachban .active{
            background: #f1f1f1;
            border-left: 3px solid #1aa5f6;
        }
        #danhsachban li:hover{
            background:#f1f1f1;
            cursor: pointer;
        }
        #danhsachban img{
            width: 50px;
            border-radius: 50%;
            float: left;
        }
        #danhsachban div{
            float: left;
            width: 200px;
            font-size: 20px;
            padding: 8px;
        }
        .khungguitin{
            position:absolute;
            bottom:0;
            left:0;
            right:0;
            height:50px;
        }
        #noidungtin{
            width:100%;
            float: left;
            border-radius: 4px;
            border: 1px solid #c2c2c2;
            padding: 10px;
            height: 60px;
        }
        #guitin{
            width: 80px;
            float: right;
            margin-top: 8px;
        }
        #tin{
            width: 100%;
            float: left;
            height: 500px;
            position: relative;
            overflow: auto;
            padding: 10px;
        }
        .tinus, .tinoa{
            width: 100%;
            float: left;
        }
        .tinoa{

        }
        .tinus{
            width: -moz-fit-content;
            float: right;
            width: fit-content;
        }

        .tinoa img{

        }
        .tinus img{

        }
        .tinoa img,.tinus img{
            border-radius: 50%;
            width: 40px;
            float: left;
            height: 40px;
        }
        .ndtin{
            float: left;
            padding: 8px;
            min-width: 100px;
            width: -moz-fit-content;
            width: fit-content;
            background: #81d1ff;
            margin: 0px 5px 0px 10px;
            border-radius: 5px;
            text-align: justify;
            max-width: 280px;
            box-shadow: 3px 3px 2px -1px #efefef;
        }
        .khungbao{
            width: 100%;
            float: left;
            margin-bottom: 10px;
            position: relative;
        }
    </style>
    <script>
        var jsondanhsach = <%=json_dsbb%>;
        var accesstoken_oa = "<%=access_token_oa%>";
    </script>
</head>
<body style="background: #f1f1f1;">
    <form id="form1" runat="server">
        <div class="container">
            <asp:HiddenField runat="server" ID="txtHDinfo" />
            <!-- Content Wrapper. Contains page content -->
            <!-- Main content -->
            <section class="content container-fluid" style="padding-bottom: 0;">
                <section class="content-header">
                    <span style="width: 100%;">
                        <img class="anhdaidien" src="https://s120.avatar.talk.zdn.vn/0/7/5/2/1/120/780fda4348205fd81f9d4dd77e2d567c.jpg" />
                        <asp:Label ID="txtTenNguoiDung" Font-Size="30px" runat="server"></asp:Label>
                    </span>
                </section>
            </section>
            <section class="content">
                <div class="box box-solid" id="khungthongtin" style="padding: 10px;border-radius: 15px;">
                    <div class="row" style="width:100%;">
                        <asp:Label runat="server" ID="txtLinkDangNhap"></asp:Label>
                        <h3 style="padding-left: 15px;margin-top: 10px;">DANH SÁCH FLOWER</h3>
                        <hr />
                        <div class="col-md-4">
                            <div class="col-md-12" style="padding: 0; margin-bottom: 10px;">
                                <input type="text" class="form-control" placeholder="Tìm kiếm ..." value="" id="otimkiem" />
                            </div>
                            <ul id="danhsachban" class="col-md-12">
                                <li class="text-center" id="guitatca">Gửi tất cả Flower (<b> <span id="soflower"></span> </b>)</li>
                            </ul>
                        </div>
                        <div id="khungtinnhan" class="col-md-8">
                            <h4 class="tennguoigui text-center" style="border-bottom: 1px solid #f1f1f1;padding: 0px 0px 25px 0px;"></h4>
                            <div id="tin">
                                <!--<div class="khungbao">
                                    <div class="tinoa">
                                        <img src="http://s120.avatar.talk.zdn.vn/7/2/8/6/75/120/b5c4d352ea101ef355be38ffc4ef8768.jpg" />
                                        <div class="ndtin">djksd hskh hk h khj h</div>
                                    </div>
                                </div>

                                <div class="khungbao">
                                    <div class="tinus">
                                        <img src="http://s120.avatar.talk.zdn.vn/7/2/8/6/75/120/b5c4d352ea101ef355be38ffc4ef8768.jpg" />
                                        <div class="ndtin">jkd ihh hoho</div>
                                    </div>
                                </div>-->

                            </div>
                            <div class="khungguitin">
                                <textarea id="noidungtin"></textarea>
                                <div class="btn btn-primary btn-sm" id="guitin">Gửi tin</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </form>
    <!-- jQuery 3 -->
    <script src="/lte/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="/lte/bower_components/bootstrap/dist/js/bootstrap.min.js" defer="defer"></script>
    <!-- AdminLTE App -->
    <script src="/lte/dist/js/adminlte.min.js" defer="defer"></script>
    <script type="text/javascript" src="/lab/js/jquery-ui.min.js" defer="defer"></script>
    <link rel="stylesheet" type="text/css" href="/lab/css/jquery-ui.min.css">

    <script type="text/javascript">
        var im="";
        var idcodinh;
        var message_id = "";
        function chukhongdau(alias) {
            var str = alias;
            str = str.toLowerCase();
            str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g,"a"); 
            str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g,"e"); 
            str = str.replace(/ì|í|ị|ỉ|ĩ/g,"i"); 
            str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g,"o"); 
            str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g,"u"); 
            str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g,"y"); 
            str = str.replace(/đ/g,"d");
            str = str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g," ");
            str = str.replace(/ + /g," ");
            str = str.trim(); 
            return str;
        }
        $(document).ready(function() {
            var info = jQuery.parseJSON($("#<%=txtHDinfo.ClientID %>").val());
            //$('.anhdaidien').attr("src", info.picture.data.url);
            jsondanhsach.map(function(d){
                $('#danhsachban').append('<li idu="'+d[0]+'"><img class="hinhthe" src="'+d[1]+'" /><div>'+d[2]+'</div></li>');
            });
            $('#soflower').text(jsondanhsach.length);
        });
        $(document).on('click','li',function() {
            $('#danhsachban li').removeClass('active');
            $(this).addClass('active');
            $('#tin').empty();
            if($(this).attr('id')=="guitatca"){
                $('.tennguoigui').text('Gửi tin nhắn đến tất cả Flower');
                $('.tennguoigui').attr("idu",'tatca');
                return false;
            }
            
            $('.tennguoigui').text('Gửi tin nhắn đến: '+$(this).find('div').text());
            $('.tennguoigui').attr("idu",$(this).attr('idu'));
            var uid = $(this).attr('idu');
            idcodinh = $(this).attr('idu');
            
            $.ajax({
                type: "POST",
                url: "zalo.aspx/LayTin",
                data: '{userId: '+uid+'}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data){
                    var dl=jQuery.parseJSON(data.d);
                    for (var i = dl.data.length-1; i >= 0; i--) {
                        if (dl.data[i].from_display_name=="Ntsoft") {
                            $('#tin').append("<div class=\"khungbao\">"+
                                    "<div class=\"tinoa\">"+
                                            "<img src=\""+dl.data[i].from_avatar+"\" />"+
                                        "<div class=\"ndtin\" mesid='"+dl.data[i].message_id+"'>"+dl.data[i].message+"</div>"+
                                    "</div>"+
                                "</div>"
                                );
                            im = dl.data[i].from_avatar;
                        }else{
                            $('#tin').append("<div class=\"khungbao\">"+
                                    "<div class=\"tinus\">"+
                                            "<img src=\""+dl.data[i].from_avatar+"\" />"+
                                        "<div class=\"ndtin\" mesid='"+dl.data[i].message_id+"'>"+dl.data[i].message+"</div>"+
                                    "</div>"+
                                "</div>"
                                );
                        }
                        message_id = dl.data[i].message_id;
                    }
                    var objDiv = document.getElementById("tin");
                    objDiv.scrollTop = objDiv.scrollHeight;
                },
                failure: function(response) {
                    console.log(response);
                }
            });

        });

        $(document).on('keyup','#otimkiem',function(){
            $('#danhsachban').find("li").remove();
            var info = jQuery.parseJSON($("#<%=txtHDinfo.ClientID %>").val());
            var key = $(this).val();
            if (jQuery.isEmptyObject(key)) {
                jsondanhsach.map(function(d){
                    $('#danhsachban').append('<li idu="'+d[0]+'"><img class="hinhthe" src="'+d[1]+'" /><div>'+d[2]+'</div></li>');
                });
                return false;
            }
            jsondanhsach.map(function(d){
                if (chukhongdau(d[2].toLowerCase()).search(chukhongdau(key.toLowerCase()))!=-1) {
                    $('#danhsachban').append('<li idu="'+d[0]+'"><img class="hinhthe" src="'+d[1]+'" /><div>'+d[2]+'</div></li>');
                }
            });
        });
        $(document).on('click','#guitin',function(){
            var mangid=[];
            if ($(".tennguoigui").attr("idu")=="tatca") {
                $('#danhsachban li:not(:first)').each(function(){
                    mangid.push($(this).attr('idu'));
                });
            }else{
                mangid.push($(".tennguoigui").attr("idu"));
            }
            if ($('.tennguoigui').text().trim().length==0) {
                tbdanger('Vui lòng chọn người nhận tin');
                return false;
            }
             $.ajax({
                type: "POST",
                url: "zalo.aspx/GuiTinNhan",
                data: '{userId: ' + JSON.stringify(mangid) + ', noidung:"'+$('#noidungtin').val()+'" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data){
                    var json=$.parseJSON(data.d);
                    if (json.errorMsg=="Success") {
                        tbsuccess("Gửi tin thành công");
                        if ($(".tennguoigui").attr("idu")=="tatca") {
                            $('#tin').empty();
                        }
                        $('#tin').append("<div class=\"khungbao\">"+
                                "<div class=\"tinoa\">"+
                                        "<img src=\"https://s120.avatar.talk.zdn.vn/0/7/5/2/1/120/780fda4348205fd81f9d4dd77e2d567c.jpg\" />"+
                                    "<div class=\"ndtin\">"+$('#noidungtin').val()+"</div>"+
                                "</div>"+
                            "</div>"
                            );
                        $('#noidungtin').val('');
                    }else{
                        tbdanger("Gửi tin không thành công");
                    }
                    var objDiv = document.getElementById("tin");
                    objDiv.scrollTop = objDiv.scrollHeight;
                },
                failure: function(response) {
                    console.log(response);
                }
            });
        });  
        var _z = setInterval(_x, 1000);
        function _x() {
            if ($.isEmptyObject(idcodinh)) {
                return false;
            }
            try{
                $.ajax({
                    type: "POST",
                    url: "zalo.aspx/LayTin",
                    data: '{userId: '+idcodinh+'}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(data){
                        var dl=jQuery.parseJSON(data.d);
                        if (message_id==dl.data[0].message_id) {
                            return false;
                        }
                        else{
                            $('#tin').empty();
                            for (var i = dl.data.length-1; i >= 0; i--) {
                                var kt = 0;
                                $('.ndtin').each(function(){
                                    if ($(this).attr('mesid')==dl.data[i].message_id) {
                                        kt==1;
                                    }
                                });
                                if(kt==1){
                                    return false;
                                }else{
                                    if (dl.data[i].from_display_name=="Ntsoft") {
                                        $('#tin').append("<div class=\"khungbao\">"+
                                                "<div class=\"tinoa\">"+
                                                        "<img src=\""+dl.data[i].from_avatar+"\" />"+
                                                    "<div class=\"ndtin\" mesid='"+dl.data[i].message_id+"'>"+dl.data[i].message+"</div>"+
                                                "</div>"+
                                            "</div>"
                                            );
                                        im = dl.data[i].from_avatar;
                                    }else{
                                        $('#tin').append("<div class=\"khungbao\">"+
                                                "<div class=\"tinus\">"+
                                                        "<img src=\""+dl.data[i].from_avatar+"\" />"+
                                                    "<div class=\"ndtin\" mesid='"+dl.data[i].message_id+"'>"+dl.data[i].message+"</div>"+
                                                "</div>"+
                                            "</div>"
                                            );
                                    }
                                }
                            }
                        } 
                        
                    },
                    failure: function(response) {
                        console.log(response);
                    }
                });
            }
            catch(e){
            }
        }
    </script>
<script type="text/javascript">(function(){var t;(t=jQuery).bootstrapGrowl=function(s,e){var a,o,l;switch(e=t.extend({},t.bootstrapGrowl.default_options,e),(a=t("<div>")).attr("class","bootstrap-growl alert"),e.type&&a.addClass("alert-"+e.type),e.allow_dismiss&&(a.addClass("alert-dismissible"),a.append('<button  class="close" data-dismiss="alert" type="button"><span aria-hidden="true">&#215;</span><span class="sr-only">Close</span></button>')),a.append(s),e.top_offset&&(e.offset={from:"bottom",amount:e.top_offset}),l=e.offset.amount,t(".bootstrap-growl").each(function(){return l=Math.max(l,parseInt(t(this).css(e.offset.from))+t(this).outerHeight()+e.stackup_spacing)}),(o={position:"body"===e.ele?"fixed":"absolute",margin:0,"z-index":"9999",display:"none"})[e.offset.from]=l+"px",a.css(o),"auto"!==e.width&&a.css("width",e.width+"px"),t(e.ele).append(a),e.align){case"center":a.css({left:"50%","margin-left":"-"+a.outerWidth()/2+"px"});break;case"left":a.css("left","20px");break;default:a.css("right","20px")}return a.fadeIn(),e.delay>0&&a.delay(e.delay).fadeOut(function(){return t(this).alert("close")}),a},t.bootstrapGrowl.default_options={ele:"body",type:"info",offset:{from:"bottom",amount:20},align:"right",width:250,delay:4e3,allow_dismiss:!0,stackup_spacing:10}}).call(this);</script>
<script type="text/javascript">function tbinfo(mess){$.bootstrapGrowl('<i class="fa fa-spinner fa-spin"></i>  '+mess, {type: 'info',delay: 6000});}function tbsuccess(mess){$.bootstrapGrowl('<i class="fa fa-check"></i>  '+mess, {type: 'success',delay: 2000});}function tbdanger(mess){$.bootstrapGrowl('<i class="fa fa-times"></i>  '+mess, {type: 'danger',delay: 2000});}function tban(){$('.bootstrap-growl').remove();}</script>
</body>
</html>
