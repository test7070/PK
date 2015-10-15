<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var t_style = '',t_ucc='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccpkk');
			});
			function q_gfPost() {
				//傑期 因為型太多,所以只顯示A~N
				q_gt('style', "where=^^noa between 'A' and 'N'^^", 0, 0, 0, "");
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style':
						t_style = 'A,B@捲、板';
						var as = _q_appendData("style", "", true);
						for ( i = 0; i < as.length; i++) {
							t_style += (t_style.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa + '.' + as[i].product;
						}
						
						q_gt('ucc', '', 0, 0, 0, "");
						break;
					case 'ucc':
						t_ucc = '';
						var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							t_ucc += (t_ucc.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa;
						}
						loadFinish();
						break;
				}
			}
			function loadFinish() {
				$('#q_report').q_report({
					fileName : 'z_uccpkk',
					options : [{
						type : '6', //[1] 1
						name : 'xdate'
					}, {
						type : '5', //[2] 2
						name : 'xitype',
						value : [q_getPara('report.all')].concat(q_getPara('uccc.itype').split(','))
					}, {
						type : '5', //[3] 3
						name : 'xbproduct',
						value : t_ucc.split('&')
					}, {
						type : '5', //[4] 4
						name : 'xeproduct',
						value : t_ucc.split('&')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXdate').mask('999/99/99');
				$('#txtXdate').val(q_date());
				$('#txtXdate').datepicker();
				//$('#Xitype').css('width', '120px');
				
				$('#Xbproduct select').change(function(e){
					$('#Xeproduct select').val($('#Xbproduct select').val());
				});
			}
			function q_boxClose(s2) {
			}

		</script>
		<style type="text/css">
			.num {
				text-align: right;
				padding-right: 2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>