<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            function getLocation(){
            	var parser = document.createElement('a');
				parser.href = document.URL;
				return parser.protocol+'//'+parser.host;		
            }
            var t_mech = '';
            $(document).ready(function() {
            	q_getId();
            	q_gt('mech', '', 0, 0, 0, "");	
            });
            
            function q_gtPost(t_name) {
            	switch (t_name) {
					case 'mech':
						t_mech = '';
						var as = _q_appendData("mech", "", true);
						for ( i = 0; i < as.length; i++) {
							t_mech += (t_mech.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].mech;
						}
						q_gf('', 'z_cubm_pk'); 
						break;
				} 
            }
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cubm_pk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_ordc_pk.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '1', //[3][4]  1
						name : 'xdate'
					}, { 
						type : '2', //[5][6]      2
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,nick',
						src : 'cust_b.aspx'
					}, {
                        type : '6', //[7]  3
                        name : 'xordeno'
                    },{
                        type : '8',//[8]  4
                        name : 'xmech',
                        value : t_mech.split('&')
                    },{
                        type : '5',//[9]  5
                        name : 'xenda',
                        value : ' @全部&Y@結案&N@未結案'.split('&')
                    }, {
                        type : '6', //[10]  6
                        name : 'noa'
                    },{
						type : '1', //[11][12]  7  完工日期
						name : 'ydate'
					}, { 
						type : '2', //[13][14]  8 操作人員
						name : 'xsss',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}]
				});
				q_popAssign();
				q_langShow();
				
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				
				$('#txtYdate1').mask('999/99/99');
				$('#txtYdate1').datepicker();
				$('#txtYdate2').mask('999/99/99');
				$('#txtYdate2').datepicker();
				
				var t_date,
                    t_year,
                    t_month,
                    t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtNoa').val(t_para.noa);
	            }
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
			//function q_boxClose(s2) {}
			
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          