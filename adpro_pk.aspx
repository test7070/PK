<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">

			var q_name = "adpro";
			var q_readonly = ['txtNoa'];
			var bbmNum = [['txtDime', 10, 2, 1],['txtWidth', 10, 1, 1],['txtLengthb', 10, 0, 1],['txtRadius', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 10, 0, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			//q_xchg = 1;
			q_desc = 1;
			aPop = new Array(
				['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
				['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				brwCount2 = 20;
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = [];
				q_mask(bbmMask);
				document.title='安全存量';
				$('#txtMon').blur(function() {
					if((q_cur==1 || q_car==2) &&emp($('#txtDatea').val())&&!emp($('#txtMon').val()))
                    $('#txtDatea').val($('#txtMon').val()+'/01');
                });
                
                $('#txtExreprice').blur(function() {
					if((q_cur==1 || q_car==2))
                    	sum();
                });
                
                $('#txtExprice').blur(function() {
					if((q_cur==1 || q_car==2) )
                    	sum();
                });
			}
			
			function sum() {
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('adpro_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtProductno').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('disabled', 'disabled');
				$('#txtProductno').focus();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);

			}

			function btnOk() {
				Lock(1, {opacity : 0});
				var t_date = '';
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
                
            }
            .dview {
                float: left;
                width: 600px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 400px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: black;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 2000px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            #dbbt {
                width: 1400px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
        </style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewProductx'>品名</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDimex'>厚</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewWidthx'>寬</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewLengthbx'>長</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewRadiusx'>短徑</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMountx'>數量</a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewWeightx'>重量</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id="product" style="text-align: center;">~product</td>
						<td id="dime" style="text-align: center;">~dime</td>
						<td id="width" style="text-align: center;">~width</td>
						<td id="lengthb" style="text-align: center;">~lengthb</td>
						<td id="radius" style="text-align: center;">~radius</td>
						<td id="mount" style="text-align: center;">~mount</td>
						<td id="weight" style="text-align: center;">~weight</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl">品名</a></td>
						<td colspan="3">
							<input id="txtProductno" type="text" class="txt" style="width:50%;" />
							<input id="txtProduct" type="text" class="txt" style="width:50%;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDime' class="lbl">厚</a></td>
						<td colspan="1"><input id="txtDime"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWidth' class="lbl">寬</a></td>
						<td colspan="1"><input id="txtWidth"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLengthb' class="lbl">長</a></td>
						<td colspan="1"><input id="txtLengthb"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRadius' class="lbl">短徑</a></td>
						<td colspan="1"><input id="txtRadius"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">數量</a></td>
						<td colspan="1"><input id="txtMount" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">重量</a></td>
						<td colspan="1"><input id="txtWeight" type="text" class="txt num c1" /></td>
					</tr>

				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>