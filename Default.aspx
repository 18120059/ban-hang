<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script language="javascript">
	function jump(stt,object)   
	{
		var total;
		var link;
		var cls=new cls_check();
		var iden;
		var dk;
		var locate;
		var name=object.id;
		if(name.search("nb")>0)
		{
		    total=document.getElementById("sotrangnb").value;
		    iden="sonb";
		    dk="nb";
		    locate="noidungnb";
	    }
	    else if(name.search("new")>0)
	    {
	        total=document.getElementById("sotrangnew").value;
		    iden="sonew";
		    dk="new";
		    locate="noidungnew";
	    }
	    //alert (object.style.color)
	    if(object.style.color!="blue")
	    {
	        //alert (1);
	        link="show_trangchu.aspx?dieukien=" + dk + "&tranghh=" + stt + "&sodong=4";
		    cls.test(link,locate);
		    for(i=1;i<=total;i++)
		    {
			    var element=eval("document.getElementById('" + iden + i +  "')");
			    if(element.id==object.id)
			    {
				    element.style.color="blue";
				    var content="<font size='4'>" + i + "</font>";
				    element.innerHTML=content;
			    }
			    else
			    {
				    element.style.color="#999900";
				    var content="<font size='2'>" + i + "</font>";
				    element.innerHTML=content;
			    }
		    }
		}
	}
</script>
 <% 
     try
     {
         //System.Data.SqlClient.
         Session["url"] = "Default.aspx";
         string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
         const int ROWS_PER_PAGE = 4;//so san pham hien thi tren 1 trang
         SqlConnection conn = new SqlConnection(connectString);
         conn.Open();
         //tao doi tuong thuc thi sql
         SqlCommand comm = new SqlCommand("phantrang_trangchu", conn);
         //chi dinh kieu thuc thi la procedure
         comm.CommandType = CommandType.StoredProcedure;
         //set gia tri dieu kien tim kiem vao procedure
         comm.Parameters.Add(new SqlParameter("@dieukien", SqlDbType.NVarChar, 5));
         comm.Parameters["@dieukien"].Value = "nb";
         //set gia tri trang hien hanh vao procedure
         comm.Parameters.Add(new SqlParameter("@tranghh", SqlDbType.Int));
         comm.Parameters["@tranghh"].Value = 1;
         //set gia tri so dong hien thi tren 1 trang vao procedure
         comm.Parameters.Add(new SqlParameter("@sodong", SqlDbType.Int));
         comm.Parameters["@sodong"].Value = ROWS_PER_PAGE;
         //lay tong so dong duoc output tu procedure
         comm.Parameters.Add(new SqlParameter("@tongdong", SqlDbType.Int));
         comm.Parameters["@tongdong"].Direction = ParameterDirection.Output;
         comm.ExecuteNonQuery();
         int sodong = int.Parse(comm.Parameters["@tongdong"].Value.ToString());
         SqlDataReader reader = comm.ExecuteReader();
         string result = "<table width='100%' bgcolor='#FFFFFF' class='Table_sp' cellspacing='0' cellpadding='0'>";
         result += "<tr bgcolor='#996633'><th colspan='4'>Sản phẩm nổi bật</th></tr>";
         result += "<tr>";
         while (reader.Read())
         {
             result += "<td align='center' valign='middle'><a href='chitietsanpham.aspx?masp=" + reader["masp"].ToString() + "'><img style='border:none' src='" + reader["hinh"].ToString() + "' width='90' height='90' alt='click vào hình để xem chi tiết sản phẩm'></td>";
         }
         result += "</tr></table>";
         Response.Write("<div id='noidungnb'>" + result + "</div>");
         result = "";
         int sotrang = sodong / ROWS_PER_PAGE;
         if (sodong % ROWS_PER_PAGE != 0)
             sotrang++;
         result = "<table width='100%'border='0' cellspacing='0' cellpadding='0'>";
         result += "<tr><td align='right'>";
         for (int i = 1; i <= sotrang; i++)
             if (i == 1)
                 result += "<span id='sonb" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:blue;cursor:pointer'><font size='4'>" + i + "</font></span>&nbsp;";
             else
                 result += "<span id='sonb" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:#999900;cursor:pointer'><font size='2'>" + i + "</font></span>&nbsp;";
         result += "</td></tr></table>";
         Response.Write("<div id='phantrang'>" + result + "</div>");
         Response.Write("<input type='hidden' name='sotrangnb' value=" + sotrang + ">");
         comm.Dispose();
         reader.Dispose();
         comm = new SqlCommand("phantrang_trangchu", conn);
         //chi dinh kieu thuc thi la procedure
         comm.CommandType = CommandType.StoredProcedure;
         //set gia tri dieu kien tim kiem vao procedure
         comm.Parameters.Add(new SqlParameter("@dieukien", SqlDbType.NVarChar, 5));
         comm.Parameters["@dieukien"].Value = "new";
         //set gia tri trang hien hanh vao procedure
         comm.Parameters.Add(new SqlParameter("@tranghh", SqlDbType.Int));
         comm.Parameters["@tranghh"].Value = 1;
         //set gia tri so dong hien thi tren 1 trang vao procedure
         comm.Parameters.Add(new SqlParameter("@sodong", SqlDbType.Int));
         comm.Parameters["@sodong"].Value = ROWS_PER_PAGE;
         //lay tong so dong duoc output tu procedure
         comm.Parameters.Add(new SqlParameter("@tongdong", SqlDbType.Int));
         comm.Parameters["@tongdong"].Direction = ParameterDirection.Output;
         comm.ExecuteNonQuery();
         sodong = int.Parse(comm.Parameters["@tongdong"].Value.ToString());
         reader = comm.ExecuteReader();
         result = "";
         result = "<table width='100%' bgcolor='#CCCCCC' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
         result += "<tr bgcolor='#996633'><th colspan='4'>Tin tức công nghệ</th></tr>";
         while (reader.Read())
         {
             result += "<tr>";
             result += "<td align='center' valign='middle' width='130'><a href='chitietsanpham.aspx?masp=" + reader["masp"].ToString() + "'><img style='border:none' src='" + reader["hinh"].ToString() + "' width='120' height='100' alt='click vào hình để xem chi tiết sản phẩm'></td>";
             result += "<td valign='middle'>&nbsp;Tên sản phẩm:" + reader["tensp"].ToString() + "<br>&nbsp;Mô tả:" + reader["mota"].ToString() + "<br>&nbsp;Giá:" + tien.tiente.chuyendoi(reader["gia"].ToString()) + " VND<br>";
             result += "&nbsp;<input type='text' size='1' class='cell' name='txt" + reader["masp"].ToString() + "' value='1' style='text-align:center'>";
             result += "&nbsp;&nbsp;<input type='button' name='cmd" + reader["masp"].ToString() + "' onclick='return addtocart(this)' value='Mua' style='font-size:13px'></td>";
             result += "</tr>";
         }
         result += "</table>";
         Response.Write("<div id='noidungnew'>" + result + "</div>");
         result = "";
         sotrang = sodong / ROWS_PER_PAGE;
         if (sodong % ROWS_PER_PAGE != 0)
             sotrang++;
         result = "<table width='100%'border='0' cellspacing='0' cellpadding='0'>";
         result += "<tr><td align='right'>";
         for (int i = 1; i <= sotrang; i++)
             if (i == 1)
                 result += "<span id='sonew" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:blue;cursor:pointer'><font size='4'>" + i + "</font></span>&nbsp;";
             else
                 result += "<span id='sonew" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:#999900;cursor:pointer'><font size='2'>" + i + "</font></span>&nbsp;";
         result += "</td></tr></table>";
         Response.Write("<div id='phantrang'>" + result + "</div>");
         Response.Write("<input type='hidden' name='sotrangnew' value=" + sotrang + ">");
         comm.Dispose();
         reader.Dispose();
         conn.Close();
     }
     catch (Exception e)
     {
         Response.Redirect("error.aspx");
     }
    
 %>
 <form id="Form1" runat =server>   
     
  
 </FORM>    
</asp:Content>

