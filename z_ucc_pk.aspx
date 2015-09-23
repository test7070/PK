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
				q_gf('', 'z_ucc_pk');
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
					fileName : 'z_ucc_pk',
					options : [{
						type : '1', //[1][2] 1
						name : 'xdate'
					}, {
						type : '5', //[3] 2
						name : 'xstktype',
						value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
					}, {
						type : '5', //[4] 3
						name : 'xitype',
						value : [q_getPara('report.all')].concat(q_getPara('uccc.itype').split(','))
					}, {
						type : '2', //[5][6] 4
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '5', //[7] 5
						name : 'xstyle',
						value : [q_getPara('report.all')].concat(t_style.split('&'))
					}, {
						type : '6', //[8] 6
						name : 'xwaste'
					}, {
						type : '1', //[9][10] 7
						name : 'xradius'
					}, {
						type : '1', //[11][12] 8
						name : 'xwidth'
					}, {
						type : '1', //[13][14] 9
						name : 'xdime'
					}, {
						type : '1', //[15][16] 10
						name : 'xlengthb'
					}, {
						type : '2', //[17] [18] 11
						name : 'xstore',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '2', //[19] [20] 12
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '5', //[21] 13
						name : 'xorderstatus',
						value : [q_getPara('report.all')].concat('1@已受訂,2@未受訂'.split(','))
					}, {
						type : '8', //[22] 14
						name : 'xisordermemo',
						value : "1@顯示已受訂明細".split(',')
					}, {
						type : '5', //[23] 15
						name : 'xsortby',
						value : ' @預設,datea@依入庫日期,productno@依品號,size@依尺寸,dime@依厚度,memo@依備註,uno@依批號,source@依鋼廠,spec@依規格'.split(',')
					}, {
						type : '8', //[24] 16
						name : 'xshowprice',
						value : "1@顯示單價".split(',')
					}, {
						type : '6', //[25] 17
						name : 'xspec'
					}, {
						type : '2', //[26][27] 18
						name : 'xtggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '8', //[28] 19
						name : 'xoption01',
						value : q_getMsg('xoption01').split('&')
					}, {
						type : '8', //[29] 20
						name : 'xproduct2',
						value : t_ucc.split('&')
					}, {
						type : '8', //[30] 21
						name : 'xstyle2',
						value : t_style.split('&')
					}, {
						type : '5', //[31] 22
						name : 'xbproduct3',
						value : t_ucc.split('&')
					}, {
						type : '5', //[32] 23
						name : 'xeproduct3',
						value : t_ucc.split('&')
					}, {
						type : '8', //[33] 24
						name : 'xoption',
						value : ('01@排除Ｈ&02@現貨&03@期貨').split('&')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#Xoption').find('input[type=checkbox]').eq(1).prop('checked',true);
				$('#Xoption').find('input[type=checkbox]').eq(2).prop('checked',true);
				
				$('#Xdate').css('width', '350px');
				$('#Xstktype').css('width', '250px');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#Xtggno').hide();
				$('#Xitype .label').css('width', '5px');
				$('#Xstktype .label').css('width', '5px');
				$('#Xitype').css('width', '120px');
				$('#Xstktype').css('width', '120px');
				$('#Xshowprice').css('width', '300px').css('height', '30px');
				$('#Xshowprice .label').css('width', '0px');
				$('#chkXshowprice').css('padding-top', '5px');
				$('#Xisordermemo').css('width', '300px').css('height', '30px');
				$('#Xisordermemo .label').css('width', '0px');
				$('#chkXisordermemo').css('padding-top', '5px');
				$('#txtXedate').mask('999/99/99');
				$('#txtXedate').val(q_date());
				$('#Xstktype select').change(function() {
					size_change();
				});
				$('#Xstktype select').val('A1').change();
				setDefaultValue();
				size_change();
				$('#Xitype .cmb').change(function() {
					if ($('#Xitype .cmb').val() == '1') {
						$('#Xtggno').hide();
					} else {
						$('#Xtggno').show();
					}
				});
				$('.report').click(function() {
					size_change();
					$('#Xorderstatus select').change();
				});
				$('#chkXisordermemo input[type="checkbox"]').click(function() {
					$('#Xorderstatus select').change();
				});
				/*$('#Xorderstatus select').change(function() {
					var showMemo = $('#chkXisordermemo input[type="checkbox"]').is(':checked');
					var nowReport = $('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report;
					if ((($(this).val() == '1') || ($(this).val() == '#non' && showMemo == true)) && (dec(nowReport.slice(-1)) <= 3)) {
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0, 8) + 'A';
						if ($(this).val() == '1') {
							$('#chkXisordermemo input[type="checkbox"]').attr('checked', false);
						}
					} else {
						$('#chkXisordermemo input[type="checkbox"]').attr('checked', false);
						$('#q_report').data('info').reportData[$('#q_report').data('info').radioIndex].report = nowReport.substring(0, 8);
					}
				});*/
				$('#Xitype .cmb').change();
				$('#Xstype select').val('A');
				$('#Xitype select').val('1');
				
				$('#chkYitype').children('input').eq(0).attr('checked', 'checked');
				$('#chkYitype').children('input').eq(1).attr('checked', 'checked');
				$('#chkYstyle').children('input').attr('checked', 'checked');
				//$('#chkYproductno').children('input').attr('checked', 'checked');
				
				$('#Xbproduct3 select').change(function(e){
					$('#Xeproduct3 select').val($('#Xbproduct3 select').val());
				});
			}

			function q_boxClose(s2) {
			}

			function setDefaultValue() {
				$('#txtXradius1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXradius2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXwidth1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXdime1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXdime2').val(9999.99).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(9999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(0);
				});
				$('#txtXlengthb2').val(99999.9).addClass('num').focusout(function() {
					$(this).val(dec($(this).val()));
					if ($(this).val() == 'NaN')
						$(this).val(99999.9);
				});
			}

			function size_change() {
				var SelectedVal = $('#Xstktype select').val().toUpperCase();
				if (!($('#Xstktype').is(":hidden"))) {
					switch (SelectedVal.substring(0,1)) {
						case 'A':
							$('#Xradius').hide();
							$('#Xwidth').show();
							$('#lblXwidth').text('厚度');
							$('#lblXdime').text('寬度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'B':
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
						case 'C':
							$('#Xradius').hide();
							$('#Xwidth').hide();
							$('#Xdime').hide();
							$('#Xlengthb').show();
							break;
						default:
							$('#Xradius').show();
							$('#Xwidth').show();
							$('#lblXwidth').text('長徑');
							$('#lblXdime').text('厚度');
							$('#Xdime').show();
							$('#Xlengthb').show();
							break;
					}
					setDefaultValue();
					$('#Xitype .cmb').change();
				}
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