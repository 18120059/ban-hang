<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<% 
    Response.ContentType = "text/html;charset=utf-8";
    string url = "timkiem.aspx?";
    string maloai = Request.QueryString["maloai"];
    if (maloai == null)
        maloai = "";
    else
        url+="maloai=" + maloai + "&";
    string manhasx = Request.QueryString["manhasx"];
    if (manhasx == null)
        manhasx = "";
    else
        url+="manhasx=" + manhasx + "&";
    int min = 0;
    int max = 0;
    //min,max tinh theo gia tien hoac tinh theo so trang hien thi
    if (Request.QueryString["min"] != null)
        min = int.Parse(Request.QueryString["min"].ToString());
    if (Request.QueryString["max"] != null)
        max = int.Parse(Request.QueryString["max"].ToString());
    url += "min=" + min.ToString() + "&max=" + max.ToString() + "&";
    int tranghh=1;
    int sodong=6;
    string tam=Request.QueryString["tranghh"];
    if(tam!=null)
        tranghh=int.Parse(tam.ToString());
    url += "trang=" + tranghh;
    tam=Request.QueryString["sodong"];
    if(tam!=null)
        sodong=int.Parse(tam.ToString());
    //Response.Write(url);
    string slhienthi=Request.QueryString["slhienthi"];
    string sotrang=Request.QueryString["sotrang"];
    if (sotrang != null && slhienthi != null)
    {
        string result = "";
        result = "<table width='100%'border='0' cellspacing='0' cellpadding='0'>";
        result += "<tr><td align='right'>";
        int sl = int.Parse(sotrang.ToString());
        if (min > 1)
            result += "<span id='lui' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + 1 + ",this)' style='color:#999900;cursor:pointer'><font size='2'>...</font></span>&nbsp;";
        for (int i = min; i <= max; i++)
        {
            if (i == tranghh)
                result += "<span id='so" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:blue;cursor:pointer'><font size='4'>" + i + "</font></span>&nbsp;";
            else
                result += "<span id='so" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:#999900;cursor:pointer'><font size='2'>" + i + "</font></span>&nbsp;";
        }
        if (sl > max)
            result += "<span id='tiep' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + 1 + ",this)' style='color:#999900;cursor:pointer'><font size='2'>...</font></span>&nbsp;";
        result += "</td></tr></table>";
        result += "<input type='hidden' name='sotrang' value=" + sotrang + ">";
        result += "<input type='hidden' name='min' value=" + min + ">";
        result += "<input type='hidden' name='max' value=" + max + ">";
        result += "<input type='hidden' name='slhienthi' value=" + slhienthi + ">";
        Response.Write(result);
    }
    else if (maloai != "" || manhasx!="" || min!=0 || max!=0)
    {
        try
        {
            Session["url"] = url;
            string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectString);
            conn.Open();
            //tao doi tuong thuc thi sql
            SqlCommand comm = new SqlCommand("phantrang_timkiem", conn);
            //chi dinh kieu thuc thi la procedure
            comm.CommandType = CommandType.StoredProcedure;
            //set gia tri dieu kien tim kiem vao procedure
            comm.Parameters.Add(new SqlParameter("@maloai", SqlDbType.NVarChar, 5));
            comm.Parameters["@maloai"].Value = maloai;
            //set gia tri dieu kien tim kiem vao procedure
            comm.Parameters.Add(new SqlParameter("@nhasx", SqlDbType.NVarChar, 5));
            comm.Parameters["@nhasx"].Value = manhasx;
            //set gia tri dieu kien tim kiem vao procedure
            comm.Parameters.Add(new SqlParameter("@min", SqlDbType.Int));
            comm.Parameters["@min"].Value = min;
            //set gia tri dieu kien tim kiem vao procedure
            comm.Parameters.Add(new SqlParameter("@max", SqlDbType.Int));
            comm.Parameters["@max"].Value = max;
            //set gia tri trang hien hanh vao procedure
            comm.Parameters.Add(new SqlParameter("@tranghh", SqlDbType.Int));
            comm.Parameters["@tranghh"].Value = tranghh;
            //set gia tri so dong hien thi tren 1 trang vao procedure
            comm.Parameters.Add(new SqlParameter("@sodong", SqlDbType.Int));
            comm.Parameters["@sodong"].Value = sodong;
            //lay tong so dong duoc output tu procedure
            comm.Parameters.Add(new SqlParameter("@tongdong", SqlDbType.Int));
            comm.Parameters["@tongdong"].Direction = ParameterDirection.Output;
            System.Data.SqlClient.SqlDataReader reader = comm.ExecuteReader();
            string result = "<table width='100%' bgcolor='#CCCCCC' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
            result += "<tr bgcolor='#996633'><th colspan='4'>Kết quả tìm kiếm</th></tr>";
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
            Response.Write(result);
        }
        catch (Exception e)
        {
            Response.Write(url);
        }
    }
%>
