<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<% 
    Response.ContentType = "text/html;charset=utf-8";
    string dk = Request.QueryString["dieukien"];
    int tranghh=int.Parse(Request.QueryString["tranghh"].ToString());
    int sodong = int.Parse(Request.QueryString["sodong"].ToString());
    string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
    SqlConnection conn = new SqlConnection(connectString);
    conn.Open();
    //tao doi tuong thuc thi sql
    SqlCommand comm = new SqlCommand("phantrang_trangchu", conn);
    //chi dinh kieu thuc thi la procedure
    comm.CommandType = CommandType.StoredProcedure;
    //set gia tri dieu kien tim kiem vao procedure
    comm.Parameters.Add(new SqlParameter("@dieukien", SqlDbType.NVarChar, 5));
    comm.Parameters["@dieukien"].Value = dk;
    //set gia tri trang hien hanh vao procedure
    comm.Parameters.Add(new SqlParameter("@tranghh", SqlDbType.Int));
    comm.Parameters["@tranghh"].Value = tranghh;
    //set gia tri so dong hien thi tren 1 trang vao procedure
    comm.Parameters.Add(new SqlParameter("@sodong", SqlDbType.Int));
    comm.Parameters["@sodong"].Value = sodong;
    //lay tong so dong duoc output tu procedure
    comm.Parameters.Add(new SqlParameter("@tongdong", SqlDbType.Int));
    comm.Parameters["@tongdong"].Direction = ParameterDirection.Output;
    SqlDataReader reader = comm.ExecuteReader();
    string result="";
    int dem = 0;
    if (dk.Equals("nb"))
    {
        result = "<table width='100%' bgcolor='#FFFFFF' class='Table_sp' cellspacing='0' cellpadding='0'>";
        result += "<tr bgcolor='#996633'><th colspan='4'>Sản phẩm nổi bật</th></tr>";
        result += "<tr>";
        while (reader.Read())
        {
            result += "<td align='center' valign='middle'><a href='chitietsanpham.aspx?masp=" + reader["masp"].ToString() + "'><img style='border:none' src='" + reader["hinh"].ToString() + "' width='90' height='90' alt='click vào hình để xem chi tiết sản phẩm'></td>";
            dem++;
        }
        for (int i = dem; i < sodong; i++)
            result += "<td width='90' height='90'>&nbsp;</td>";
        result += "</tr></table>";
    }
    else if(dk.Equals("new"))
    {
        result = "<table width='100%' bgcolor='#CCCCCC' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
        result += "<tr bgcolor='#996633'><th colspan='4'>Tin tức công nghệ</th></tr>";
        while (reader.Read())
        {
            result += "<tr>";
            result += "<td align='center' valign='middle' width='130'><a href='chitietsanpham.aspx?masp=" + reader["masp"].ToString() + "'><img style='border:none' src='" + reader["hinh"].ToString() + "' width='120' height='100' alt='click vào hình để xem chi tiết sản phẩm'></td>";
            result += "<td valign='middle'>&nbsp;Tên sản phẩm:" + reader["tensp"].ToString() + "<br>&nbsp;Mô tả:" + reader["mota"].ToString() + "<br>&nbsp;Giá:" + reader["gia"].ToString() + "<br>";
            result += "&nbsp;<input type='text' size='1' class='cell' name='txt" + reader["masp"].ToString() + "' value='1' style='text-align:center'>";
            result += "&nbsp;&nbsp;<input type='button' name='cmd" + reader["masp"].ToString() + "' onclick='return addtocart(this)' value='Mua' style='font-size:13px'></td>";
            result += "</tr>";
            dem++;
        }
        result += "</table>";
    }   
    Response.Write(result);
%>
