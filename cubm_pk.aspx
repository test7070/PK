<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
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
			q_tables = 's';
			var q_name = "cubm";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtWeight', 10, 3, 1], ['txtMount', 10, 2, 1],['txtWeight2', 10, 3, 1], ['txtMount2', 10, 2, 1],['txtWeight3', 10, 3, 1], ['txtMount3', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_desc = 1;
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';

			aPop = new Array(
				['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']
				, ['txtSssno_', 'btnSss_', 'sss', 'noa,namea', 'txtSssno_,txtSname_', 'sss_b.aspx']
			);
			brwCount2 = 5;
			
			var ucc = new Array();
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('ucc', '', 0, 0, 0, "getUcc", r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				for(var i=0;i<q_bbsCount;i++){
					//備註第一個字是"*",重量會重新計算
					if($('#txtMemo_'+i).val().substring(0,1)!='*')
						continue;
						
					productno = $.trim($('#txtProductno_'+i).val()); 
					mount = $.trim($('#txtMount_'+i).val());
					size = $.trim($('#txtSize_'+i).val()).replace(' ','');
					patt = /(.*)T\*(\d+)\*(\d+)/;
					if(!patt.test(size)){
						$('#txtWeight_'+i).val(0);
						continue;
					}
					dime = size.replace(patt,'$1');
					width = size.replace(patt,'$2');
					length = size.replace(patt,'$3');
					try{
						dime = isNaN(parseFloat(dime))?0:parseFloat(dime); 
					}catch(e){
						dime = 0;
					}
					try{
						width = isNaN(parseFloat(width))?0:parseFloat(width); 
					}catch(e){
						width = 0;
					}
					try{
						length = isNaN(parseFloat(length))?0:parseFloat(length); 
					}catch(e){
						length = 0;
					}
					try{
						mount = isNaN(parseFloat(mount))?0:parseFloat(mount);
					}catch(e){
						mount = 0;
					}
					density = 0;
					for(var j=0;j<ucc.length;j++){
						if(ucc[j].noa==productno){
							density = ucc[j].density ;
							break;
						}
					}
					weight = round(q_mul(q_mul(q_mul(q_mul(dime,width),length),density),mount)/ 1000000,2);
					console.log(dime*width*length*density*mount/1000000);
					$('#txtWeight_'+i).val(weight);
				}	
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtBtime','99:99'],['txtEtime','99:99']];
				bbsMask = [['txtDatea', r_picd],['txtBtime','99:99'],['txtEtime','99:99'],['txtEdate', r_picd]];
				q_mask(bbmMask);
				
				$('#btnOrdesImport').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						t_noa = $('#txtNoa').val();
						t_where ='';
						q_box("orde_pk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({no:t_noa,page:'cubm_pk'}), "orde_cubm", "95%", "95%", '');
					}
				});
				
				$('#checkAll').click(function(e){
					for(var i=0;i<q_bbsCount;i++)
						$('#chkEnda_'+i).prop('checked',$('#checkAll').prop('checked'));
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'orde_cubm':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtDatea,txtProductno,txtProduct,txtSize,txtMount,txtWeight,txtCustno,txtCust,txtDatea'
                        	, as.length, as, 'noa,no2,datea,productno,product,size,mount,weight,custno,cust,datea', 'txtOrdeno','');             	
                        }else{
                        	Unlock(1);
                        }
                        sum();
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'getUcc':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined){
							for(var i=0;i<as.length;i++){
								ucc.push({noa:as[i].noa,density:as[i].density});
							}
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
					default:
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			
			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cubm') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cubm_pk_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
			}
			
			function bbsAssign() {/// 表身運算式
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if ($('#btnMinus_' + i).hasClass('isAssign')) 
						continue;
					$('#txtSssno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnSss_'+n).click();
                    });
                    $('#txtProductno_'+i).change(function(e){
						sum();
					});
                    $('#txtSize_'+i).change(function(e){
						sum();
					});
					$('#txtMount_'+i).change(function(e){
						sum();
					});
					$('#txtMemo_'+i).change(function(e){
						sum();
					});
				}
				_bbsAssign();
				$('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				sum();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_cubm_pk.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cubm_pk', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
				/*if (!as['ordeno'] && !as['no2']) {//不存檔條件
					as[bbsKey[1]] = '';
					/// noq 為空，不存檔
					return;
				}*/
				//2017/12/20 改為判斷日期
				if (!as['datea'] ) {//不存檔條件
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						sum();
						break;
					default:
                        break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#btnOrdesImport').prop( "disabled", true );
                    $('#checkAll').prop( "disabled", true );
                } else {	
                    $('#txtDatea').datepicker();
                    $('#btnOrdesImport').prop( "disabled", false );
                    $('#checkAll').prop( "disabled", false );
                }
			}
			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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

			function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}

		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				width: 400px;
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
				width: 600px;
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
				width: 1500px;
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
				width: 1600px;
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
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="display:none; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:200px; color:black;"><a id='vewMech'>機台</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewSss'>操作人</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td style="display:none;" id='noa'>~noa</td>
						<td align="center" id='mech'>~mech</td>
						<td align="center" id='sname'>~sname</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMech' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtMechno" type="text" style="float:left;width:25%;"/>
							<input id="txtMech" type="text" style="float:left;width:75%;"/>
						</td>
						<td><input id="checkAll"  type="checkbox" class="txt c1" title="結案"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id='lblTime' class="lbl">時間</a></td>
						<td colspan="2">
							<input id="txtBtime" type="text" class="txt" style="float:left;width:40%;"/>
							<a style="float:left;"> ～ </a>
							<input id="txtEtime" type="text" class="txt" style="float:left;width:40%;"/>
						</td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtSssno" type="text" style="float:left;width:25%;"/>
							<input id="txtSname" type="text" style="float:left;width:75%;"/>
						</td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4"><textarea id="txtMemo" class="txt c1" rows="5"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><input id="btnOrdesImport" type="button" value="訂單匯入"/></td>
						
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:180px;">訂單號碼</td>
					<td align="center" style="width:100px;">日期</td>
					<td align="center" style="width:100px;">客戶</td>
					<td align="center" style="width:150px;"><a>品號<BR>品名</a></td>
					<td align="center" style="width:200px;">尺寸</td>
					<td align="center" style="width:80px;">數量</td>
					<td align="center" style="width:80px;">重量</td>
					<td align="center" style="width:80px;">米數</td>
					<td align="center" style="width:150px;">時間</td>
					<td align="center" style="width:100px;">完工日期</td>
					<td align="center" style="width:120px;">操作人員</td>
					<td align="center" style="width:80px;">完工數量</td>
					<td align="center" style="width:80px;">完工重量</td>
					<td align="center" style="width:40px;">結案</td>
					<td align="center" style="width:150px;">備註</td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtOrdeno.*" type="text" style="width:65%;float:left;" />
						<input type="text" id="txtNo2.*" style="width:28%;float:left;" />						
					</td>
					<td><input type="text" id="txtDatea.*" style="width:95%;text-align:center;" /></td>
					<td>
						<input type="text" id="txtCustno.*" style="display:none;" />
						<input type="text" id="txtCust.*" style="width:95%;text-align:center;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:45%;float:left;" />
						<input type="text" id="txtProduct.*" style="width:45%;float:left;" />
						<input class="btn" id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td><input type="text" id="txtSize.*" style="width:95%;text-align:center;" /></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtMount2.*" type="text" class="txt num" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtBtime.*" style="float:left;width:40%;text-align:center;" />
						<a style="float:left;width:10%;text-align:center;">~</a>
						<input type="text" id="txtEtime.*" style="float:left;width:40%;text-align:center;" />
					</td>
					<td><input type="text" id="txtEdate.*" style="width:95%;text-align:center;" /></td>
					<td>
						<input id="txtSssno.*" type="text" style="width:45%;float:left;" />
						<input type="text" id="txtSname.*" style="width:45%;float:left;" />
						<input class="btn" id="btnSss.*" type="button" style="display:none;"/>
					</td>
					<td><input id="txtMount3.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWeight3.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="chkEnda.*" type="checkbox"/></td>
					<td><input id="txtMemo.*" type="text" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
