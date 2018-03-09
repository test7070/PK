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
			var uccgaItem = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				
				q_gf('', 'z_anavccpk');
						
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
						loadFinish();
						break;
				} 
			}
			function loadFinish(){
				$('#q_report').q_report({
					fileName : 'z_anavccpk',
					options : [{
						type : '1', //[1][2]  1
						name : 'xdate'
					}, {
						type : '2', //[3][4]  2
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[5][6] 3
						name : 'xstore',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '5', //[7] 4
						name : 'xbproduct',
						value : t_ucc.split('&')
					}, {
						type : '5', //[8] 5
						name : 'xeproduct',
						value : t_ucc.split('&')
					},{
						type : '1', //9][10] 6
						name : 'xdime'
					},{
						type : '1', //[11][12] 7
						name : 'xwidth'
					},{
						type : '1', //[13][14] 8
						name : 'xlength'
					}, {
                        type : '8',//[15]  9
                        name : 'xstype',
                        value : q_getPara('vccst.stype').split(',')
                    },{
						type : '6', //[16] 10
						name : 'xsource'
					},{
						type : '6', //[17] 11
						name : 'xstoreno'
					}, {
						type : '5', //[18] 12
						name : 'xsort',
						value : 'weight@重量,total@銷售金額,rate@毛利率,profit@毛利'.split(',')
					}, {
                        type : '8',//[19]  13
                        name : 'xoption01',
                        value : '明細'.split('&')
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				
				$('#txtXdime1').css('text-align','right').val('0');
				$('#txtXdime2').css('text-align','right').val('9999');
				$('#txtXwidth1').css('text-align','right').val('0');
				$('#txtXwidth2').css('text-align','right').val('9999');
				$('#txtXlength1').css('text-align','right').val('0');
				$('#txtXlength2').css('text-align','right').val('99999');
				
				$('#chkXstype').children().eq(0).prop('checked',true);//預設 買賣
				$('#Xbproduct select').change(function(e){
					$('#Xeproduct select').val($('#Xbproduct select').val());
				});
				$('#Xeproduct select').prop('selectedIndex', $('#Xeproduct select').children().length-1);
				
				var t_date, t_year, t_month, t_day;
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
			}
			function q_boxClose(s2) {
			}
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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