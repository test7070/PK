<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="cubm";
        var q_readonly = ['txtMech'];
        var bbmNum = [['txtGmount',15,0,0], ['txtMount',15,0,0],['txtGweight',15,2,0], ['txtWeight',15,2,0], ['txtLength',15,2,0]]; 
        var bbmMask = []; 
        q_sqlCount = 6; 
        brwCount = 6; 
        brwList =[];
        brwNowPage = 0;
        brwKey = 'noa';
        brwCount2 = 10;

        aPop = new Array(['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech','mech_b.aspx'],
        				 ['txtUno', 'lblUno', 'view_uccc', 'uno', 'txtUno', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%']);
      
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
         	q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
           	q_getFormat();
			bbsMask = [['txtDatea', r_picd],['txtBtime','99:99'],['txtEtime','99:99']];
			q_mask(bbsMask);
			
			q_cmbParse("cmbTrantype",q_getPara('sys.tran'));
			
			$('#txtUno').blur(function(){
				q_gt('view_uccb', "where=^^uno='"+$('#txtUno').val()+"'^^", 0, 0, 0, 'productSpec');
			});
			$('#txtOrderno').blur(function(){
				q_gt('view_ordes', "where=^^noa='"+$('#txtOrderno').val()+"' and no2='"+$('#txtNo2').val()+"'^^", 0, 0, 0, 'ordeSpec',r_accy);
			});
			$('#txtNo2').blur(function(){
				q_gt('view_ordes', "where=^^noa='"+$('#txtOrderno').val()+"' and no2='"+$('#txtNo2').val()+"'^^", 0, 0, 0, 'ordeSpec',r_accy);
			});
			
        }

        function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2);
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'productSpec': 
                	var as = _q_appendData("view_uccb", "", true);             	
					if (as[0] != undefined) {
						//存於資料庫以'/'分割資料
						$('#txtProduct').val(as[0].productno+'/'+as[0].product+'/'+as[0].spec+'/'+as[0].size+'/'+as[0].weight+'/'+as[0].mount);
						//畫面顯示
						$('#textP1').val(as[0].productno);
						$('#textP2').val(as[0].product);
						$('#textP3').val(as[0].spec);
						$('#textP4').val(as[0].size);
						$('#textP5').val(as[0].weight+'kg');
						$('#textP6').val(as[0].mount);
					}         
                    break;
                case 'ordeSpec': 
                	var as = _q_appendData("view_ordes", "", true);
					if (as[0] != undefined) {
						//存於資料庫以'/'分割資料				
						$('#txtOrdespec').val(as[0].productno+'/'+as[0].product+'/'+as[0].spec+'/'+as[0].size+'/'+as[0].weight+'/'+as[0].mount);
						//畫面顯示
						$('#textO1').val(as[0].productno);
						$('#textO2').val(as[0].product);
						$('#textO3').val(as[0].spec);
						$('#textO4').val(as[0].size);
						$('#textO5').val(as[0].weight+'kg');
						$('#textO6').val(as[0].mount);
					}         
                    break;    
                case q_name: 
                	if (q_cur == 4)   
                        q_Seek_gtPost();            
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4) 
                return;

            q_box('cubm_pk_s.aspx', q_name + '_s', "500px", "40%", q_getMsg( "popSeek"));
        }

        function btnIns() {
           _btnIns();
			$('#txtNoa').val('AUTO');
			$('#txtNoq').val('001');
			$('#txtOrderno').val(q_getHref()[1]=='undefined'?'':q_getHref()[1]);
			$('#txtDatea').val(q_date()); 
			refreshBbm();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            refreshBbm();
        }

        function btnPrint() {
 			q_box('z_cubm_pk.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
        }
        
        function btnOk() {
            t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);
			if (t_err.length > 0) {
				alert(t_err);
				return;
			}
            
            var t_noa = trim($('#txtNoa').val());
			var t_date = trim($('#txtDatea').val());
			if (t_noa.length == 0 || t_noa == "AUTO")
			   	q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
			else
			    wrServer(t_noa);
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
      
        function refresh(recno) {
            _refresh(recno);
            refreshBbm();

        }
        
        function refreshBbm() {
			$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
			
			for(var i=1; i<=6; i++){
				$('#textP'+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
				$('#textO'+i).css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');	
			}
		}	

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            refreshBbm();
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

        function btnSeek(){
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
				overflow: hidden;
			}
			.dview {
				float: left;
				border-width: 0px;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 5px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 850px;
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
				height: 43px;
			}
			/*.tbbm tr td {
				width: 10%;
			}*/
			
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
				color: blue;
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
			.txt.c2 {
				width: 95%;
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
				width: 1260px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"], select {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="datea" style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td width="5%"></td>
						<td width="8%"></td>
						<td width="5%"></td>
						<td width="8%"></td>
						<td width="5%"></td>
						<td width="8%"></td>						
						<td class="tdZ"></td>
					</tr>
					<tr>						
						<td><span> </span><a id='lblDatea' class="lbl" ></a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></a></td>
						<td><span> </span><a id='lblOrderno' class="lbl "></a></td>
						<td>
							<input id="txtOrderno" type="text" class="txt c1" style="width: 70%"/>
							<input id="txtNo2" type="text" class="txt c1" style="width: 30%"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></a></td>
						<td style="display: none"><input id="txtNoq" type="text" class="txt c1" /></a></td>	
					</tr>
					<tr>				
						<td><span> </span><a id='lblUno' class="lbl btn"></a></td>						
						<td colspan="3"><input id="txtUno" type="text" class="txt c1" style="float: left;"/></a></td>
						<td><span> </span><a id='lblTrantype' class="lbl"></a></td>
						<td><select id="cmbTrantype" class="txt c1" ></select></a></td>					
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl"></a></td>
						<td colspan="5" style="display: none"><input id="txtProduct" type="text" class="txt c1" /></a></td>
						<td colspan="5">
							<input id="textP1" type="text" class="txt c1" style="width: 12%"/></a>
							<input id="textP2" type="text" class="txt c1" style="width: 16%"/></a>
							<input id="textP3" type="text" class="txt c1" style="width: 16%"/></a>
							<input id="textP4" type="text" class="txt c1" style="width: 32%"/></a>
							<input id="textP5" type="text" class="txt c1" style="text-align:right; width: 12%"/></a>
							<input id="textP6" type="text" class="txt c1" style="text-align:right; width: 12%"/></a>
						</td>					
					</tr>
					<tr>
						<td><span> </span><a id='lblOrdespec' class="lbl"></a></td>
						<td colspan="5" style="display: none"><input id="txtOrdespec" type="text" class="txt c1" /></a></td>
						<td colspan="5">
							<input id="textO1" type="text" class="txt c1" style="width: 12%"/></a>
							<input id="textO2" type="text" class="txt c1" style="width: 16%"/></a>
							<input id="textO3" type="text" class="txt c1" style="width: 16%"/></a>
							<input id="textO4" type="text" class="txt c1" style="width: 32%"/></a>
							<input id="textO5" type="text" class="txt c1" style="text-align:right; width: 12%"/></a>
							<input id="textO6" type="text" class="txt c1" style="text-align:right; width: 12%"/></a>
						</td>						
					</tr>
					<tr>
						<td><span> </span><a id='lblMech' class="lbl btn"></a></td>	
						<td>
							<input id="txtMechno"  type="text" style="width: 25%;"/>
							<input id="txtMech"  type="text" style="width: 75%; color:green;"/>
						</td>
						<td><span> </span><a id='lblTime' class="lbl"></a></td>
						<td>
							<input id="txtBtime"  type="text" style="width: 45%;"/>
							<span style="width: 15px;float: left;text-align: center">~</span>
							<input id="txtEtime"  type="text" style="width: 45%;"/>					
						</td>
						<td><span> </span><a id='lblLength' class="lbl"></a></td>
						<td><input id="txtLength" type="text" class="txt c1 num" /></a></td>	
					</tr>
					<tr>
						<td><span> </span><a id='lblGmount' class="lbl"></a></td>
						<td><input id="txtGmount" type="text" class="txt c1 num" /></a></td>
						<td><span> </span><a id='lblGweight' class="lbl"></a></td>
						<td><input id="txtGweight" type="text" class="txt c1 num" /></a></td>
						<td><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMount' class="lbl"></a></td>
						<td><input id="txtMount" type="text" class="txt c1 num" /></a></td>
						<td><span> </span><a id='lblWeight' class="lbl"></a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></a></td>
						<td><span> </span><a id='lblWorker2' class="lbl"></a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></a></td>						
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>