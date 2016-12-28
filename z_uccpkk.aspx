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
			var t_style = '',t_ucc='',t_store='';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccpkk');
			});
			function q_gfPost() {
				q_gt('ucc', '', 0, 0, 0, "");
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ucc':
						t_ucc = ' @';
						var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							t_ucc += (t_ucc.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa;
						}
						q_gt('store', '', 0, 0, 0, "");
						break;
					case 'store':
						t_store = '';
						var as = _q_appendData("store", "", true);
						for ( i = 0; i < as.length; i++) {
							t_store += (t_store.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].store;
						}
						loadFinish();
						break;
				}
			}
			function loadFinish() {
				$('#q_report').q_report({
					fileName : 'z_uccpkk',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_uccpkk.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '6', //[3] 1
						name : 'xdate'
					},{
						type : '6', //[4] 2
						name : 'xmon'
					},{
						type : '5', //[5] 3
						name : 'xbproduct',
						value : t_ucc.split('&')
					}, {
						type : '5', //[6] 4
						name : 'xeproduct',
						value : t_ucc.split('&')
					}, {
						type : '8', //[7] 5
						name : 'xstore',
						value : t_store.split('&')
					}, {
						type : '8', //[8] 6
						name : 'xoption',
						value : "detail@明細,waste@廢料".split(',')
					},{
						type : '6', //[9] 7
						name : 'xuno'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXdate').mask('999/99/99');
				$('#txtXdate').val(q_date());
				$('#txtXdate').datepicker();
				$('#txtXmon').mask('999/99');
				$('#txtXmon').val(q_date().substring(0,6));
				
				$('#Xbproduct select').change(function(e){
					$('#Xeproduct select').val($('#Xbproduct select').val());
				});
				$('#Xeproduct select').prop('selectedIndex', $('#Xeproduct select').children().length-1);
				$('#Xdate').width(610);
				$('#Xmon').width(610);
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