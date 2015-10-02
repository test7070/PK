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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "rc2";
			var q_readonly = ['txtRc2atax', 'txtTgg', 'txtAccno', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtWeight', 'txtTotal', 'txtTax', 'txtTotalus'];
			var q_readonlys = ['txtMoney','txtSprice'];
			var bbmNum = [['txtPrice', 15, 3, 1], ['txtRc2atax', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 3, 1], ['txtFloata', 10, 4, 1]];
			var bbsNum = [['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtMount', 10, 2, 1], ['txtTheory', 10, 3, 1], ['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1],['txtSprice', 15, 3, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_desc = 1;
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';

			aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype,tel,trantype,zip_fact,addr_fact', 'txtTggno,txtTgg,txtNick,txtPaytype,txtTel,cmbTrantype,txtPost,txtAddr', 'tgg_b.aspx']
			, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			, ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx']
			, ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']
			, ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			, ['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx']
			, ['txtAddr2', '', 'view_road', 'memo,zipcode', '0txtAddr2,txtPost2', 'road_b.aspx']
			, ['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%']
			, ['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			, ['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
			, ['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_', 'style_b.aspx']);
			//, ['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%']);
			
			brwCount2 = 12;
			var isinvosystem = false;
			//購買發票系統
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('rc2a', 'stop=1 ', 0, 0, 0, "isinvosystem");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
				//判斷是否有買發票系統
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
				$('#cmbTaxtype').val((($('#cmbTaxtype').val()) ? $('#cmbTaxtype').val() : '1'));
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_moneyus = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_unit = '';
				var t_float = q_float('txtFloata');
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);

				for (var j = 0; j < q_bbsCount; j++) {
				    t_weights = 0;
					t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
					t_product = $.trim($('#txtProduct_' + j).val());
					if (t_unit.length == 0 && t_product.length > 0) {
						if (t_product.indexOf('管') > 0)
							t_unit = '支';
						else
							t_unit = 'KG';
						$('#txtUnit_' + j).val(t_unit);
					}
					//---------------------------------------
					if (t_kind == 'A') {
						q_tr('txtDime_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
						q_tr('txtRadius_' + j, q_float('textSize4_' + j));
					} else if (t_kind == 'B') {
						q_tr('txtRadius_' + j, q_float('textSize1_' + j));
						q_tr('txtWidth_' + j, q_float('textSize2_' + j));
						q_tr('txtDime_' + j, q_float('textSize3_' + j));
						q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
					} else {//鋼筋、胚
						q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
					}
					getTheory(j);
					var t_Product = $('#txtProduct_' + j).val();
					if (t_Product.indexOf('管') > -1 && dec($('#txtWeight_' + j).val()) == 0) {
						$('#txtWeight_' + j).val(getTheory(j));
					}
					//---------------------------------------
					var t_styles = $.trim($('#txtStyle_' + j).val());
					var t_unos = $.trim($('#txtUno_' + j).val());
					var t_dimes = $.trim($('#txtDime_' + j).val());
					if (!(t_styles == '' && t_unos == '' && t_dimes == 0))
						t_weights = q_float('txtWeight_' + j);
					else if(q_getPara('sys.project')=='pk' || q_getPara('sys.project')=='rk'){
						t_weights = q_float('txtWeight_' + j);
					}
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					
					if($('#chkAprice_'+j).prop('checked')){
						t_moneys = q_float('txtTotal_' + j);
					}
					else{
						if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M²' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
							//批   裕承隆  是拿來當運費的單位   不能用
							if(q_getPara('sys.comp').substring(0,2)=="裕承" && t_unit == '批' )
								t_moneys = q_mul(t_prices, t_mounts);
							else
								t_moneys = q_mul(t_prices, t_weights);
						} else {
							t_moneys = q_mul(t_prices, t_mounts);
						}
						
						if(q_getPara('sys.project').toUpperCase()=='RK'){
							t_moneys = round(t_moneys,0);
						}else{
							if (t_float == 0) {
							t_moneys = round(t_moneys, 0);
							} else {
								t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
								t_moneys = round(q_mul(t_moneys, t_float), 0);
							}	
						}
						
						$('#txtTotal_' + j).val(FormatNumber(t_moneys));
					}

					t_weight = q_add(t_weight, t_weights);
					t_mount = q_add(t_mount, t_mounts);
					
					if(q_getPara('sys.project').toUpperCase()=='RK'){
						if (t_float == 0) {
							t_money = q_add(t_money,round(t_moneys, 0));
							t_moneyus=0;
						} else {
							t_money = q_add(t_money, round(q_mul(t_moneys, t_float), 0));
							t_moneyus = q_add(t_moneyus, round(t_moneys, 2));
						}
					}else{
						t_money = q_add(t_money, t_moneys);
					}
					
				}
				t_total = t_money;
				t_tax = 0;
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				if (!isinvosystem) {
					switch ($('#cmbTaxtype').val()) {
						case '1':
							// 應稅
							t_tax = round(q_mul(t_money, t_taxrate), 0);
							t_total = q_add(t_money, t_tax);
							break;
						case '2':
							//零稅率
							t_tax = 0;
							t_total = q_add(t_money, t_tax);
							break;
						case '3':
							// 內含
							t_tax = q_sub(t_money, round(q_div(t_money, q_add(1, t_taxrate)), 0));
							t_total = t_money;
							t_money = q_sub(t_total, t_tax);
							break;
						case '4':
							// 免稅
							t_tax = 0;
							t_total = q_add(t_money, t_tax);
							break;
						case '5':
							// 自定
							$('#txtTax').attr('readonly', false);
							$('#txtTax').css('background-color', 'white').css('color', 'black');
							t_tax = round(q_float('txtTax'), 0);
							t_total = q_add(t_money, t_tax);
							break;
						case '6':
							// 作廢-清空資料
							t_money = 0, t_tax = 0, t_total = 0;
							break;
						default:
					}
				}
				t_price = q_float('txtPrice');
				if (t_price != 0) {
					$('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight, t_price), 0)));
				}
				$('#txtWeight').val(FormatNumber(t_weight));

				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				if (t_float == 0)
					$('#txtTotalus').val(0);
				else
					$('#txtTotalus').val(FormatNumber(t_moneyus));
			}

			function mainPost() {// 載入資料完，未 refresh 前
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入					
				$('#txtMemo').change(function(){
					if ($('#txtMemo').val().substr(0,1)=='*')
						$('#txtMon').removeAttr('readonly');
					else
						$('#txtMon').attr('readonly', 'readonly');
				});
				
				$('#txtMon').click(function(){
					if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
						q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
				});
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "95%", q_getMsg('btnAccc'), true);
				});
				
				$('#lblOrdc').click(function() {
					if (!(q_cur == 1 || q_cur == 2))
						return;
					lblOrdc();
				});
				
				$('#cmbKind').change(function() {
					size_change();
				});
				
				$('#txtAddr').change(function() {
					var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "", r_accy);
				});
				
				$('#lblInvono').click(function() {
					t_where = '';
					t_invo = $('#txtInvono').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
					}
				});
				
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('#lblLcno').text('報關號碼');
				}
				
				$('#lblLcno').click(function() {
					t_where = '';
					t_lcno = $('#txtLcno').val();
					if (t_lcno.length > 0) {
						if(q_getPara('sys.project').toUpperCase()=='RK'){
							t_where = "entryno='" + t_lcno + "'";
							q_box("delist.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'delist', "95%", "95%", '報關/贖單作業');
						}else{
							t_where = "lcno='" + t_lcno + "'";
							q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
						}
					}
				});
				
				$('#txtFloata').change(function() {
					sum();
				});
				
				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				
				$('#txtTotal').change(function() {
					sum();
				});
				
				$('#txtPrice').change(function() {
					sum();
				});
				
				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});

				if (isinvosystem) {
					$('.istax').hide();
					$('#txtRc2atax').show();
				}
			}

			function q_boxClose(s2) {///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
				var
				ret;
				switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
					case 'ordcs':
						if (q_cur > 0 && q_cur < 4) {
							ordcsArray = getb_ret();
							if (ordcsArray && ordcsArray[0] != undefined) {
								var distinctArray = new Array;
								var inStr = '';
								for (var i = 0; i < ordcsArray.length; i++) {
									distinctArray.push(ordcsArray[i].noa);
								}
								distinctArray = distinct(distinctArray);
								for (var i = 0; i < distinctArray.length; i++) {
									inStr += "'" + distinctArray[i] + "',";
								}
								inStr = inStr.substring(0, inStr.length - 1);
								var t_where = "where=^^ ordeno in(" + inStr + ") ^^";
								q_gt('rc2s', t_where, 0, 0, 0, "", r_accy);
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}

			function distinct(arr1) {
				var uniArray = [];
				for (var i = 0; i < arr1.length; i++) {
					var val = arr1[i];
					if ($.inArray(val, uniArray) === -1) {
						uniArray.push(val);
					}
				}
				return uniArray;
			}

			function GetOrdcnoList() {
				var ReturnStr = new Array;
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = trim($('#txtOrdeno_' + i).val());
					if (thisVal.length > 0)
						ReturnStr.push(thisVal);
				}
				ReturnStr = distinct(ReturnStr).sort();
				return ReturnStr.toString();
			}

			var ordcsArray = new Array;
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {/// 資料下載後 ...
				switch (t_name) {
					case 'getRc2atax':
						var as = _q_appendData("rc2a", "", true);
						if (as[0] != undefined) {
							$('#txtRc2atax').val(q_trv(as[0].tax, 0, 1));
							var t_noa = $('#txtNoa').val();
							for (var i = 0; i < abbm.length; i++) {
								if (abbm[i].noa == t_noa) {
									abbm[i].rc2atax = as[0].tax;
									break;
								}
							}
						}
						break;
					case 'isinvosystem':
						var as = _q_appendData("rc2a", "", true);
						if (as[0] != undefined) {
							isinvosystem = true;
							$('.istax').hide();
						} else {
							isinvosystem = false;
						}
						q_gt('style', '', 0, 0, 0, '');
						break;
					case 'btnOk_checkuno':
						var as = _q_appendData("view_uccb", "", true);
						if (as[0] != undefined) {
							var msg = '';
							for (var i = 0; i < as.length; i++) {
								msg += (msg.length > 0 ? '\n' : '') + as[i].uno + ' 此批號已存在!!\n【' + as[i].action + '】單號：' + as[i].noa;
							}
							alert(msg);
							Unlock(1);
							return;
						} else {
							getUno();
						}
						break;
					case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].nick);
						}
						Unlock(1);
						$('#txtNoa').val('AUTO');
						$('#txtDatea').val(q_date());
						//$('#txtMon').val(q_date().substring(0, 6));
						$('#txtDatea').focus();
						size_change();
						break;
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbPart2", z_coin);
						if(abbm[q_recno])
							$('#cmbPart2').val(abbm[q_recno].coin);
						
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case 'rc2s':
						var as = _q_appendData("rc2s", "", true);
						for (var i = 0; i < ordcsArray.length; i++) {
							if(q_getPara('sys.project').toUpperCase()=='RK' || q_getPara('sys.comp').substring(0,2)=="傑期"){
								if ((ordcsArray[i].mount <= 0 && ordcsArray[i].weight <= 0) || ordcsArray[i].noa == '' || dec(ordcsArray[i].cnt) == 0) {
									ordcsArray.splice(i, 1);
									i--;
								}
							}else{
								if (ordcsArray[i].mount <= 0 || ordcsArray[i].weight <= 0 || ordcsArray[i].noa == '' || dec(ordcsArray[i].cnt) == 0) {
									ordcsArray.splice(i, 1);
									i--;
								}
							}
						}
						if (ordcsArray[0] != undefined) {
							for (var i = 0; i < q_bbsCount; i++) {
								$('#btnMinus_' + i).click();
							}
							var newB_ret = new Array;
							for (var j = 0; j < ordcsArray.length; j++) {
								if (dec(ordcsArray[j].cnt) > 1) {
									var n_mount = round(q_div(dec(ordcsArray[j].mount), dec(ordcsArray[j].cnt)), 0);
									var n_weight = round(q_div(ordcsArray[j].weight, dec(ordcsArray[j].cnt)), 0);
									if ((ordcsArray[j].product).indexOf('捲') == -1) {
										ordcsArray[j].mount = n_mount;
										ordcsArray[j].weight = n_weight;
									} else {
										ordcsArray[j].weight = round(q_div(ordcsArray[j].weight, dec(ordcsArray[j].mount)), 0);
										ordcsArray[j].mount = 1;
									}
									ordcsArray[j].uno = '';
									for (var i = 0; i < dec(ordcsArray[j].cnt); i++) {
										newB_ret.push(ordcsArray[j]);
									}
									ordcsArray.splice(j, 1);
									j--;
								} else {
									newB_ret.push(ordcsArray[j]);
								}
							}
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtOrdeno,txtNo2,txtPrice,txtMount,txtWeight,txtTotal,txtMemo,txtClass,txtStyle,txtUnit,txtUnit2', newB_ret.length, newB_ret
							, 'uno,productno,product,spec,size,dime,width,lengthb,radius,noa,no2,price,mount,weight,total,memo,class,style,unit,unit2', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							t_where = "where=^^ noa='" + newB_ret[0].noa + "'";
							q_gt('ordc', t_where, 0, 0, 0, "", r_accy);
							bbsAssign();
							size_change();
							sum();
							
							if(q_getPara('sys.project').toUpperCase()=='RK'){
								var distinctArray = new Array;
								var inStr = '';
								for (var i = 0; i < q_bbsCount; i++) {
									if(!emp($('#txtOrdeno_'+i).val()))
										distinctArray.push($('#txtOrdeno_'+i).val()+'-'+$('#txtNo2_'+i).val());
								}
								distinctArray = distinct(distinctArray);
								for (var i = 0; i < distinctArray.length; i++) {
									inStr += "'" + distinctArray[i] + "',";
								}
								inStr = inStr.substring(0, inStr.length - 1);
							
								//抓取報關成本
								var t_where = "where=^^ b.ordcno+'-'+b.no2 in (" + inStr + ") "+(emp($('#txtLcno').val())?"":(" and charindex(a.entryno,'"+$('#txtLcno').val()+"')>0 ") ) +" ^^";
								q_gt('deli_payb', t_where, 0, 0, 0, "", r_accy);
							}
						}
						ordcsArray = new Array;
						break;
					case 'deli_payb':
						var as = _q_appendData("deli", "", true);
						for (var i = 0; i < q_bbsCount; i++) {
							var t_cost=0;
							for (var j = 0; j < as.length; j++) {
								if($('#txtOrdeno_'+i).val()==as[j].ordcno && $('#txtNo2_'+i).val()==as[j].no2){
									var pbmoney=dec(as[j].pbtotalus)!=0?dec(as[j].pbtotalus):q_div(dec(as[j].pbmoney),dec(as[j].floata));//payb費用
									//deli費用分攤方式
									if(as[j].feetype=='2'){
										t_cost=q_add(t_cost,q_mul(pbmoney,q_div(dec(as[j].inmount),dec(as[j].tinmount))));
									}else if(as[j].feetype=='5'){
										t_cost=q_add(t_cost,q_mul(pbmoney,q_div(dec(as[j].inweight),dec(as[j].tinweight))));
									}else  if(as[j].feetype=='3'){
										t_cost=q_add(t_cost,q_mul(pbmoney,q_div(dec(as[j].mweight),dec(as[j].tmweight))));
									}else  if(as[j].feetype=='4'){
										t_cost=q_add(t_cost,q_mul(pbmoney,q_div(dec(as[j].cuft),dec(as[j].tcuft))));
									}else{
										t_cost=q_add(t_cost,q_mul(pbmoney,q_div(dec(as[j].money),dec(as[j].tmoney))));
									}
								}
							}
							if(t_cost!=0){
								var t_unit = $.trim($('#txtUnit_' + i).val()).toUpperCase();
								var t_sprice=0;
								if (t_unit.length == 0 || t_unit == 'KG' || t_unit == 'M2' || t_unit == 'M²' || t_unit == 'M' || t_unit == '批' || t_unit == '公斤' || t_unit == '噸' || t_unit == '頓') {
									t_sprice=q_div(q_add(q_float('txtTotal_'+i),t_cost),q_float('txtWeight_'+i));
								}else{
									t_sprice=q_div(q_add(q_float('txtTotal_'+i),t_cost),q_float('txtMount_'+i));
								}
								if(t_sprice==Infinity){
									$('#txtSprice_'+i).val($('#txtPrice_'+i).val());
								}else{
									$('#txtSprice_'+i).val(round(t_sprice,3));
								}
							}else{
								$('#txtSprice_'+i).val($('#txtPrice_'+i).val());
							}
						}
						
						var t_lcno=$('#txtLcno').val();
						for (var j = 0; j < as.length; j++) {
							if(t_lcno.indexOf(as[j].entryno)==-1){
								t_lcno+=(t_lcno.length>0?',':'')+as[j].entryno;
							}
						}
						$('#txtLcno').val(t_lcno);
						break;
					case 'ordc':
						var as = _q_appendData("ordc", "", true);
						if (as[0] != undefined) {
							$('#txtTggno').val(as[0].tggno);
							$('#txtTgg').val(as[0].tgg);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtTel').val(as[0].tel);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtPost').val(as[0].post);
							$('#txtAddr').val(as[0].addr);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtPost2').val(as[0].post2);
							$('#txtAddr2').val(as[0].addr2);
						}
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'cust' :
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							var CustAddr = trim(as[0].addr_fact);
							if (CustAddr.length > 0) {
								$('#txtAddr').val(CustAddr);
								$('#txtPost').val(as[0].zip_fact);
							}
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						var err_str = '';
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (dec(as[i].gweight) > 0) {
									err_str += as[i].uno + '已領料，不能刪除!!\n';
								}
							}
							if (trim(err_str).length > 0) {
								alert(err_str);
								return;
							} else {
								_btnDele();
							}
						} else {
							_btnDele();
						}
						break;
					case 'startdate':
						var as = _q_appendData('tgg', '', true);
						var t_startdate='';
						if (as[0] != undefined) {
							t_startdate=as[0].startdate;
						}
						if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).slice(-2)){
							$('#txtMon').val($('#txtDatea').val().substr(0, 6));
						}else{
							var t_date=$('#txtDatea').val();
							var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
				    		nextdate.setMonth(nextdate.getMonth() +1)
				    		t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
							$('#txtMon').val(t_date);
						}
						check_startdate=true;
						btnOk();
						break;
					default:
						if (t_name.substring(0, 9) == 'checkUno_') {
							var n = t_name.split('_')[1];
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								var t_uno = $('#txtUno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
								$('#txtUno_' + n).focus();
							}
						} else if (t_name.substring(0, 14) == 'btnOkcheckUno_') {
							var n = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccb", "", true);
							if (as[0] != undefined) {
								var t_uno = $('#txtUno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
								Unlock(1);
								return;
							} else {
								btnOk_checkUno(n - 1);
							}
						}else if(t_name.substring(0, 11) == 'getproduct_'){
     						var t_seq = parseInt(t_name.split('_')[1]);
	                		as = _q_appendData('dbo.getproduct', "", true);
	                		if(as[0]!=undefined){
	                			$('#txtProduct_'+t_seq).val(as[0].product);
	                		}else{
	                			$('#txtProduct_'+t_seq).val('');
	                		}
	                		break;
                        }
						break;
				}
			}

			function lblOrdc() {
				var t_tggno = trim($('#txtTggno').val());
				var t_where = '';
				t_where = " view_ordcs.enda='0' and kind='" + $('#cmbKind').val() + "' " + (t_tggno.length > 0 ? q_sqlPara2("tggno", t_tggno) : "");
				t_where += " and b.enda='0'";
				if(q_getPara('sys.comp').substring(0,2)=="傑期")
					t_where += " order by noa,no2";
				
				q_box("ordcsst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbPart2').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				$('#txtRc2atax').val(0);
				var t_noa = $('#txtNoa').val();
				for (var i = 0; i < abbm.length; i++) {
					if (abbm[i].noa == t_noa) {
						abbm[i].rc2atax = 0;
						break;
					}
				}
				var s1 = xmlString.split(';');
				abbm[q_recno]['accno'] = s1[0];
				$('#txtAccno').val(s1[0]);
				if ($.trim($('#txtInvono').val()).length > 0)
					q_gt('rc2a', "where=^^noa='" + $.trim($('#txtInvono').val()) + "'^^", 0, 0, 0, 'getRc2atax', r_accy);
				Unlock(1);
			}
			
			var check_startdate=false;
			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				Lock(1, {
					opacity : 0
				});
				
				$('#txtOrdcno').val(GetOrdcnoList());
				//日期檢查
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtDatea').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				
				//判斷起算日,寫入帳款月份
				//104/09/30 如果備註沒有*字就重算帳款月份
				//if(!check_startdate && emp($('#txtMon').val())){
				if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){	
					var t_where = "where=^^ noa='"+$('#txtTggno').val()+"' ^^";
					q_gt('tgg', t_where, 0, 0, 0, "startdate", r_accy);
					Unlock(1);
					return;
				}
				check_startdate=false;
				
				/*if ($('#txtMon').val().length > 0 && !q_cd($('#txtMon').val() + '/01')) {
					alert(q_getMsg('lblMon') + '錯誤。');
					Unlock(1);
					return;
				}*/
				
				if ($.trim($('#txtStoreno').val()).length > 0) {
                    for (var i = 0; i < q_bbsCount; i++) {
                        $('#txtStoreno_' + i).val($.trim($('#txtStoreno').val()));
                        $('#txtStore_' + i).val($.trim($('#txtStore').val()));

                    }
                }
				//檢查批號
				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = i + 1; j < q_bbsCount; j++) {
						if ($.trim($('#txtUno_' + i).val()).length > 0 && $.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())) {
							alert('【' + $.trim($('#txtUno_' + i).val()) + '】' + q_getMsg('lblUno_st') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
							Unlock(1);
							return;
						}
					}
				}
				var t_where = '';
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtUno_' + i).val()).length > 0)
						t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + $.trim($('#txtNoa').val()) + "'))";
				}
				if (t_where.length > 0)
					q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
				else
					getUno();
			}

			function getUno() {
				var t_buno = '　';
				var t_datea = '　';
				var t_style = '　';
				for (var i = 0; i < q_bbsCount; i++) {
					if (i != 0) {
						t_buno += '&';
						t_datea += '&';
						t_style += '&';
					}
					if ($('#txtUno_' + i).val().length == 0 ) {
						if(q_getPara('sys.comp').substring(0,2)=='傑期' && $('#txtProductno_'+i).val().toUpperCase()=='OEM'){
							
						}else{
							t_buno += '';
							t_datea += $('#txtDatea').val();
							t_style += $('#txtStyle_' + i).val();
						}
					}
				}
				q_func('qtxt.query.getuno', 'uno.txt,getuno,' + t_buno + ';' + t_datea + ';' + t_style + ';');
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.getuno':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if (as.length != q_bbsCount) {
								alert('批號取得異常。');
							} else {
								for (var i = 0; i < q_bbsCount; i++) {
									if ($('#txtUno_' + i).val().length == 0) {
										if(q_getPara('sys.comp').substring(0,2)=='傑期' && $('#txtProductno_'+i).val().toUpperCase()=='OEM'){
							
										}else{
											$('#txtUno_' + i).val(as[i].uno);
										}
									}
								}
							}
						}
						if (q_cur == 1)
							$('#txtWorker').val(r_name);
						else
							$('#txtWorker2').val(r_name);
						sum();
						var t_noa = trim($('#txtNoa').val());
						var t_date = trim($('#txtDatea').val());
						if (t_noa.length == 0 || t_noa == "AUTO")
							q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
						else
							wrServer(t_noa);
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('rc2st_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
			}

			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList,
					ucc : t_uccArray,
					radius : t_Radius,
					width : t_Width,
					dime : t_Dime,
					lengthb : t_Lengthb,
					mount : t_Mount,
					style : t_Style,
					productno : t_Productno,
					round : 3
				};
				t_theory = theory_st(theory_setting);
				;
				t_theory = (dec(t_theory) == 0 ? $('#txtWeight_' + b_seq).val() : t_theory);
				return t_theory;
			}

			var btnCert_Seq = -1;
			///用來給q_box開啟cert時判斷位置
			function bbsAssign() {/// 表身運算式
				$('.btnCert').val($('#lblCert_st').text());
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#chkAprice_'+j).click(function(e){refreshBbs();});
						$('#btnCert_' + j).click(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							btnCert_Seq = n;
							t_where = '';
							t_uno = $('#txtUno_' + n).val();
							if (t_uno.length > 0) {
								t_where = "noa='" + t_uno + "'";
								q_box("cert_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cert', "95%", "95%", q_getMsg('popCert'));
							}
						});
						$('#txtUno_' + j).change(function(e) {
							if ($('#cmbTypea').val() != '2') {
								var n = $(this).attr('id').replace('txtUno_', '');
								var t_uno = $.trim($(this).val());
								var t_noa = $.trim($('#txtNoa').val());
								q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
							}
						});
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtWeight_' + j).change(function() {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#txtTotal_' + j).change(function() {
							sum();
						});
						$('#txtStyle_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStyle_', '');
                            $('#btnStyle_'+n).click();
                        });
                        $('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
						//計算理論重
						$('#textSize1_' + j).change(function() {
							sum();
						});
						$('#textSize2_' + j).change(function() {
							sum();
						});
						$('#textSize3_' + j).change(function() {
							sum();
						});
						$('#textSize4_' + j).change(function() {
							sum();
						});
						$('#txtSize_' + j).change(function(e) {
							if ($.trim($(this).val).length == 0)
								return;
							var n = $(this).attr('id').replace('txtSize_', '');
							var data = tranSize($.trim($(this).val()));
							$(this).val(tranSize($.trim($(this).val()), 'getsize'));
							$('#textSize1_' + n).val('');
							$('#textSize2_' + n).val('');
							$('#textSize3_' + n).val('');
							$('#textSize4_' + n).val('');
							if ($('#cmbKind').val() == 'A1') {//鋼捲鋼板
								if (!(data.length == 2 || data.length == 3)) {
									alert(q_getPara('transize.error01'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
								$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
								$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
								sum();
							} else if ($('#cmbKind').val() == 'A4') {//鋼胚
								if (!(data.length == 2 || data.length == 3)) {
									alert(q_getPara('transize.error04'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
								$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
								$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
							} else if ($('#cmbKind').val() == 'B2') {//鋼管
								if (!(data.length == 3 || data.length == 4)) {
									alert(q_getPara('transize.error02'));
									return;
								}
								if (data.length == 3) {
									$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
									$('#textSize3_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
									$('#textSize4_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
								} else {
									$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
									$('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
									$('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
									$('#textSize4_' + n).val((data[3] != undefined ? (data[3].toString().length > 0 ? (isNaN(parseFloat(data[3])) ? 0 : parseFloat(data[3])) : 0) : 0));
								}
							} else if ($('#cmbKind').val() == 'C3') {//鋼筋
								if (data.length != 1) {
									alert(q_getPara('transize.error03'));
									return;
								}
								$('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
							} else {
								//nothing
							}
							sum();
						});
					}
				}
				_bbsAssign();
				size_change();
				refreshBbs();
				if(q_getPara('sys.project').toUpperCase()=='PK')
					$('.pk').show();
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('.sprice').show();
					$('.rk').show();
				}
			}

			function btnIns() {
				_btnIns();
				$('#cmbTaxtype').val(1);
				Lock(1, {
					opacity : 0
				});
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if(q_getPara('sys.project').toUpperCase()=='PK' && !emp($('#txtOrdeno').val())){
					alert('由報關單轉來禁止修改');
				}
				_btnModi();
				$('#txtDatea').focus();
				size_change();
				sum();
			}

			function btnPrint() {
				t_where = "noa=" + $('#txtNoa').val();
				if(q_getPara('sys.project').toUpperCase()=='RK')
					q_box("z_rc2_rkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'rc2_rk', "95%", "95%", m_print);
				else if(q_getPara('sys.comp').substring(0,2)=='傑期')
					q_box("z_rc2_pkp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'rc2_pk', "95%", "95%", m_print);
				else
					q_box("z_rc2stp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
				// key_value
			}

			function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
				if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec'] && !as['size'] && !dec(as['total'])) {//不存檔條件
					as[bbsKey[1]] = '';
					/// noq 為空，不存檔
					return;
				}

				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['kind'] = abbm2['kind'];
				if (abbm2['storeno'])
					as['storeno'] = abbm2['storeno'];

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if(q_getPara('sys.project').toUpperCase()=='PK')
					$('.pk').show();
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('.sprice').show();
				}
				size_change();
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
				if (isinvosystem)
					$('.istax').hide();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
                        var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_' + b_seq).focus();
                        break;
                    case 'txtStyle_':
                   		var t_productno = $.trim($('#txtProductno_'+b_seq).val());
	                	var t_style = $.trim($('#txtStyle_'+b_seq).val());
	                	var t_comp = q_getPara('sys.comp');          	
	                	q_gt('getproduct',"where=^^[N'"+t_productno+"',N'"+t_style+"',N'"+t_comp+"')^^", 0, 0, 0, "getproduct_"+b_seq); 
                        $('#txtStyle_'+b_seq).blur();
                        break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_getPara('sys.project').toUpperCase()=='PK')
					$('.pk').show();
				if(q_getPara('sys.project').toUpperCase()=='RK'){
					$('.sprice').show();
				}
					
				size_change();
				//限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
				if ($('#txtMemo').val().substr(0,1)=='*')
					$('#txtMon').removeAttr('readonly');
				else
					$('#txtMon').attr('readonly', 'readonly');
					
				refreshBbs();
			}
			function refreshBbs(){
				//金額小計自訂
				for(var i=0;i<q_bbsCount;i++){
					$('#txtTotal_'+i).attr('readonly','readonly');
					if($('#chkAprice_'+i).prop('checked')){
						$('#txtTotal_'+i).css('color','black').css('background-color','white');
						if(q_cur==1 || q_cur==2)
							$('#txtTotal_'+i).removeAttr('readonly');
					}else{
						$('#txtTotal_'+i).css('color','green').css('background-color','rgb(237,237,237)');
					}
				}
			}
			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
				if (q_tables == 's')
					bbsAssign();
				/// 表身運算式
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
				if(q_getPara('sys.project').toUpperCase()=='PK' && !emp($('#txtOrdeno').val())){
					alert('由報關單轉來禁止刪除');
				}
				
				var t_where = 'where=^^ uno in(' + getBBSWhere('Uno') + ') ^^';
				q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
			}

			function btnCancel() {
				_btnCancel();
			}

			function getBBSWhere(objname) {
				var tempArray = new Array();
				for (var j = 0; j < q_bbsCount; j++) {
					tempArray.push($('#txt' + objname + '_' + j).val());
				}
				var TmpStr = distinct(tempArray).sort();
				TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
				return TmpStr;
			}

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				$('#cmbKind').val((($('#cmbKind').val()) ? $('#cmbKind').val() : q_getPara('vcc.kind')));
				var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
				t_kind = t_kind.substr(0, 1);
				if (t_kind == 'A') {
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					$('#Size').css('width', '220px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#txtSpec_' + j).css('width', '220px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					$('#Size').css('width', '300px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#txtSpec_' + j).css('width', '300px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else {//鋼筋和鋼胚
					$('#lblSize_help').text(q_getPara('sys.lblSizec'));
					$('#Size').css('width', '55px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#txtSpec_' + j).css('width', '55px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}
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
				width: 300px;
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
				width: 800px;
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
				width: 2250px;
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
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
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
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td> </td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCno" type="text" style="float:left;width:25%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblOrdc' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtOrdcno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtTggno" type="text" style="float:left;width:25%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:75%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4"><input id="txtTel"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:87%;"/>
							<select id="combPaytype" style="float:left; width:26px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost2"  type="text" style="float:left; width:25%;"/>
							<input id="txtAddr2"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblStoreno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtStoreno"  type="text" style="float:left; width:40%;"/>
							<input id="txtStore"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbPart2" style="float:left;width:80px;" onchange='coin_chg()'> </select>
						</td>
						<td><span> </span><a id='lblLcno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtLcno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax" type="text" class="txt num c1 istax" />
							<input id="txtRc2atax" type="text" class="txt num c1 " style="display:none;" />
						</td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbTaxtype" style="float:left;width:80px;" > </select>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1" /></td>
						<td> </td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td>
							<input id="txtAccno" type="text"  class="txt c1"/>
							<input id="txtOrdeno" type="hidden"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:250px;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:120px;"><a>品號<BR>品名</a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:80px;"><a>等級</a></td>
					<td align="center" style="width:140px;display:none;" class="pk">規範<BR>國別</td>
					<td align="center" style="width:340px;" id='Size'>
						<a id='lblSize_help'> </a><BR>
						<a id='lblSize_st'> </a>
					</td>
					<td align="center" style="width:150px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:80px;display:none;" class="pk"><a>進貨<BR>厚度</a></td>
					<td align="center" style="width:80px;display:none;" class="pk"><a>進貨<BR>寬度</a></td>
					<td align="center" style="width:80px;display:none;" class="pk"><a>進貨<BR>長度</a></td>
					<td align="center" style="width:50px;display:none;" class="pk rk"><a id='lblSource'>鋼廠</a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:50px;display:none;" class="pk"><a>數量<br>單位</a></td>
					<td align="center" style="width:80px;"><a id='lblWeights_st'> </a></td>
					<td align="center" style="width:50px;"><a>計價<br>單位</a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:80px;display:none;" class="sprice"><a id='lblSprices_st'>成本單價</a></td>
					<td align="center" style="width:100px;"><a id='lblTotals_st'> </a></td>
					<td align="center" style="width:20px;">自訂<br>金額</td>
					<td align="center">
						<a id='lblMemos_st'> </a><br>
						<a id='lblCert_st' style="display:none;"> </a>
					</td>
					<td align="center" style="width:250px;"><a id='lblUno2_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblStoreno_st'> </a></td>
					<td align="center" style="width:60px;"><a id='lblPlace_st'> </a></td>
					<td align="center" style="width:190px;"><a id='lblOrdcnos_st'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnUno.*" type="button" value='.' style="float:left;width:20px;display:none;"/>
						<input id="txtUno.*" type="text" style="float:left;width:95%;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;" />
						<input type="text" id="txtProduct.*" style="width:95%;" />
						<input class="btn" id="btnProduct.*" type="button" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtStyle.*" style="width:95%;text-align:center;" />
						<input id="btnStyle.*" type="button" style="display:none;" value="."/>
					</td>
					<td><input id="txtClass.*" type="text" style='width: 95%;'/></td>
					<td style="display:none;" class="pk">
                        <input id="txtUcolor.*" type="text" style="width:95%;"/>
                        <input id="txtScolor.*" type="text" style="width:95%;"/>
                    </td>
					<td>
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >x</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
						<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td><input id="txtSize.*" type="text" style="width:95%;"/></td>
					<td style="display:none;" class="pk"><input  id="txtDime2.*" type="text" class="txt num" style="width:95%;"/></td>
					<td style="display:none;" class="pk"><input  id="txtLengthc.*" type="text" class="txt num" style="width:95%;"/></td>
					<td style="display:none;" class="pk"><input  id="txtLengthd.*" type="text" class="txt num" style="width:95%;"/></td>
					<td style="display:none;" class="pk rk"><input  id="txtSource.*" type="text" style="width:95%;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
					<td style="display:none;" class="pk"><input id="txtUnit2.*" type="text" style="width:95%;"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtUnit.*" type="text" style="width:95%;"/></td>
					<td>
						<input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td style="display:none;" class="sprice"><input id="txtSprice.*" type="text"  class="txt num sprice" style="width:95%;"/></td>
					<td>
						<input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/>
						<input id="txtGweight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td><input id="chkAprice.*" type="checkbox"/></td>
					<td>
						<input id="txtMemo.*" type="text" style="width:95%;"/>
						<input id="btnCert.*" class="btnCert" type="button" style="width:95%;"/>
					</td>
					<td ><input id="txtUno2.*" type="text" style="width:90%;"/></td>
					<td>
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
						<input type="text" id="txtStoreno.*"  style="width:70px; float:left;"/>
						<span style="display:block; width:20px;float:left;"> </span>
						<input type="text" id="txtStore.*"  style="width:70px; float:left;"/>
					</td>
					<td><input id="txtPlace.*" type="text" style="width:90%;"/></td>
					<td>
						<input id="txtOrdeno.*" type="text"  style="width:140px;float:left;"/>
						<input id="txtNo2.*" type="text"  style="width:40px;float:left;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
