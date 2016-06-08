<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "orde_cubm", t_content = "where=^^['','')^^", bbsKey = ['noa','no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	
	            	if(t_para.page=='cubm_pk'){
	            		q_name = "orde_cubm";
	            		t_content = "where=^^['"+t_para.no+"','"+t_para.page+"')^^";
	            	}
	            }catch(e){
	            }    
	            brwCount = -1;
                mainBrow(0, t_content);
                
                /*
	            mainBrow(0       時  
            	textBox  readonly="readonly" 才有效
            	不過  bbsAssign() 就沒觸發
	            */
	           
	           /*
	            mainBrow(6       時  
            	textBox  readonly="readonly" 沒效
	            */
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
				
				
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					/*case q_name:
						abbs = _q_appendData(q_name, "", true);
						refresh();
						break;*/
				}
			}

            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++)
                	$('#lblNo_'+i).text(i+1);
            }
            function bbsAssign() {
				
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>
		
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:2%; max-width: 2%;"> </td>
					<td align="center" style="width:7%;">預交日期</td>
					<td align="center" style="width:13%;">訂單號碼</td>
					<td align="center" style="width:8%;">客戶</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:8%;">規範<BR>國別</td>
					<td align="center" style="width:14%;">尺寸</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:3%;">單位</td>
					<td align="center" style="width:5%;">重量</td>
					<td align="center" style="width:3%;">單位</td>
					<td align="center" style="width:5%;">完工<BR>數量</td>
					<td align="center" style="width:5%;">完工<BR>重量</td>
					<td align="center" style="width:5%;">未完工<BR>數量</td>
					<td align="center" style="width:5%;">未完工<BR>重量</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;"> </th>
					<td align="center" style="width:2%; max-width: 2%;"> </td>
					<td align="center" style="width:7%;">預交日期</td>
					<td align="center" style="width:13%;">訂單號碼</td>
					<td align="center" style="width:8%;">客戶</td>
					<td align="center" style="width:10%;">品名</td>
					<td align="center" style="width:8%;">規範<BR>國別</td>
					<td align="center" style="width:14%;">尺寸</td>
					<td align="center" style="width:5%;">數量</td>
					<td align="center" style="width:3%;">單位</td>
					<td align="center" style="width:5%;">重量</td>
					<td align="center" style="width:3%;">單位</td>
					<td align="center" style="width:5%;">完工<BR>數量</td>
					<td align="center" style="width:5%;">完工<BR>重量</td>
					<td align="center" style="width:5%;">未完工<BR>數量</td>
					<td align="center" style="width:5%;">未完工<BR>重量</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:2%; max-width: 2%;"><a id="lblNo.*" style="font-weight: bold;text-align: center;" readonly="readonly"> </a></td>
					<td style="width:7%;"><input id="txtDatea.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:13%;">
						<input id="txtNoa.*" type="text" style="float:left;width:70%;"  readonly="readonly" />
						<input id="txtNo2.*" type="text" style="float:left;width:25%;"  readonly="readonly" />
					</td>
					<td style="width:8%;"><input id="txtCust.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:10%;"><input id="txtProduct.*" type="text" style="float:left;width:100%;"  readonly="readonly" /></td>
					<td style="width:8%;">
						<input id="txtUcolor.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
						<input id="txtScolor.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					
					<td style="width:14%;">
						<input id="txtDime.*" type="text" style="float:left;width:28%;"  readonly="readonly" />
						<a align="center" style="float:left;width:5%">x</a>
						<input id="txtWidth.*" type="text" style="float:left;width:28%;"  readonly="readonly" />
						<a align="center" style="float:left;width:5%">x</a>
						<input id="txtLengthb.*" type="text" style="float:left;width:28%;"  readonly="readonly" />
						<input id="txtSize.*" type="text" style="float:left;width:100%;"  readonly="readonly" />
					</td>
					<td style="width:5%;"><input id="txtMount.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:3%;"><input id="txtUnit2.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtWeight.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:3%;"><input id="txtUnit.*" type="text" style="float:left;width:100%;text-align: center;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtMount3.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtWeight3.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtEmount.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
					<td style="width:5%;"><input id="txtEweight.*" type="text" style="float:left;width:100%;text-align: right;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

