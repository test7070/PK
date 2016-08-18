<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
        public class ParaIn
        {
        	public string uno,memo;
        }
        public void Page_Load()
        {
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));

            //連接字串      
            string connString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            //資料
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"if exists(select * from unolist where uno=@uno)
                    begin
	                    update unolist set memo=@memo where uno=@uno
                    end
                    else
                    begin
	                    insert into unolist(uno,memo)values(@uno,@memo)
                    end";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@uno", itemIn.uno);
                cmd.Parameters.AddWithValue("@memo", itemIn.memo);
                cmd.ExecuteNonQuery(); 
                connSource.Close();
            }
            Response.Write("done");
        }    
    </script>