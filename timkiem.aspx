<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<%--Download source code tai Sharecode.vn--%>
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
		var min;
		var max;
		var sl;
	    total=document.getElementById("sotrang").value;
	    dk=document.getElementById("dk").value;
	    min=document.getElementById("min").value;
	    max=document.getElementById("max").value;
	    if(object.id!="tiep" && object.id!="lui")
	    {
	        iden="so";
	        //alert (dk);
	        if(object.style.color!="blue")
	        {
	            locate="noidung";
	            link="show_timkiem.aspx?" + dk + "&tranghh=" + stt + "&sodong=6";
	            //alert (link);
		        cls.test(link,locate);
		        for(i=min;i<=max;i++)
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
		else if(object.id=="tiep")
		{
		    sl=document.getElementById("slhienthi").value;
		    min=parseInt(max) + 1;
		    max=parseInt(min)+parseInt(sl)-1;
		    if(max>total)
		        max=total;
		    link="show_timkiem.aspx?min=" + min + "&max=" + max + "&sotrang=" + total + "&slhienthi=" + sl + "&tranghh=" + min;
		    //alert (link);
		    locate="phantrang";
		    cls.test(link,locate);
		    stt=min;
		    link="show_timkiem.aspx?" + dk + "&tranghh=" + stt + "&sodong=6";
		    //alert (link);
		    locate="noidung";
		    cls.test(link,locate);
		}
		else if(object.id=="lui")
		{
		    sl=document.getElementById("slhienthi").value;
		    max=parseInt(min)-1;
		    min=parseInt(max)-parseInt(sl) + 1;
		    link="show_timkiem.aspx?min=" + min + "&max=" + max + "&sotrang=" + total + "&slhienthi=" + sl + "&tranghh=" + max;
		    locate="phantrang";
		    cls.test(link,locate);
		    stt=max;
		    link="show_timkiem.aspx?" + dk + "&tranghh=" + stt + "&sodong=6";
		    locate="noidung";
		    cls.test(link,locate);
		}
	}
</script>
 <% 
    string url = "timkiem.aspx?";
    string dk="";    
    string maloai = Request.QueryString["maloai"];
    if (maloai == null)
        maloai = "";
    else
        dk += "maloai=" + maloai + "&";
    string manhasx = Request.QueryString["manhasx"];
    if (manhasx == null)
    {
        if (Request.Form["nhasx"] == null)
            manhasx = "";
        else
        {
            manhasx = Request.Form["nhasx"].ToString();
            dk += "manhasx=" + manhasx + "&";
        }
    }
    else
        dk += "manhasx=" + manhasx + "&";
    string gia = "";
    int min=0;
    int max=0;
    if (Request.Form["gia"] == null)
    {
        if (Request.QueryString["min"] != null)
            min = int.Parse(Request.QueryString["min"].ToString());
        if (Request.QueryString["max"] != null)
            max = int.Parse(Request.QueryString["max"].ToString());
        if(min!=0 || max!=0)
            dk += "min=" + min + "&max=" + max;
    }
    else
    {
        gia = Request.Form["gia"].ToString();
        if (gia != "")
        {
            string[] tam = gia.Split('-');
            min = int.Parse(tam[0]);
            max = int.Parse(tam[1]);
            dk += "min=" + min + "&max=" + max;
        }
    } 
    string tam1 = Request.QueryString["trang"];//bien trang chi ton tai khi tu chi tiet san pham quay ve
    int trang = 0;
    if (tam1 == null)
        trang = 1;
    else
        trang = int.Parse(tam1.ToString());
    if(min!=0 || max!=0)
        url += dk + "&trang=" + trang;
     else
        url += dk + "trang=" + trang;
    //Response.Write(url);
    if (maloai != "" || manhasx!="" || min!=0 || max!=0)
    {
        Session["url"] = url;
        //Response.Write(url);
        //Response.Write(manhasx);
        try
        {
            string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
            const int ROWS_PER_PAGE = 6;//so san pham hien thi tren 1 trang
            const int PAGES_SHOW = 12;//so trang duoc hien thi mot lan
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
            comm.Parameters["@tranghh"].Value = trang;
            //set gia tri so dong hien thi tren 1 trang vao procedure
            comm.Parameters.Add(new SqlParameter("@sodong", SqlDbType.Int));
            comm.Parameters["@sodong"].Value = ROWS_PER_PAGE;
            //lay tong so dong duoc output tu procedure
            comm.Parameters.Add(new SqlParameter("@tongdong", SqlDbType.Int));
            comm.Parameters["@tongdong"].Direction = ParameterDirection.Output;
            comm.ExecuteNonQuery();
            int sodong = int.Parse(comm.Parameters["@tongdong"].Value.ToString());
            SqlDataReader reader = comm.ExecuteReader();
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
            Response.Write("<div id='noidung'>" + result + "</div>");
            result = "";
            int sotrang = sodong / ROWS_PER_PAGE;
            if (sodong % ROWS_PER_PAGE != 0)
                sotrang++;
            result = "<table width='100%'border='0' cellspacing='0' cellpadding='0'>";
            result += "<tr><td align='right'>";
            //Response.Write(trang / PAGES_SHOW);
            int kq = trang / PAGES_SHOW;
            min = 1 + kq * PAGES_SHOW;
            max = min + PAGES_SHOW - 1;
            if (max > sotrang)
                max = sotrang;
            if (min > 1)
                result += "<span id='lui' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + 1 + ",this)' style='color:#999900;cursor:pointer'><font size='2'>...</font></span>&nbsp;";
            for (int i = min; i <= max; i++)
            {
                if (i == trang)
                    result += "<span id='so" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:blue;cursor:pointer'><font size='4'>" + i + "</font></span>&nbsp;";
                else
                    result += "<span id='so" + i + "' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + i + ",this)' style='color:#999900;cursor:pointer'><font size='2'>" + i + "</font></span>&nbsp;";
            }
            if (sotrang > max)
                result += "<span id='tiep' onmouseover='over(this)' onmouseout='out(this)' onclick='jump(" + 1 + ",this)' style='color:#999900;cursor:pointer'><font size='2'>...</font></span>&nbsp;";
            result += "</td></tr></table>";
            result += "<input type='hidden' name='sotrang' value=" + sotrang + ">";
            result += "<input type='hidden' name='min' value=" + min + ">";
            result += "<input type='hidden' name='max' value=" + max + ">";
            result += "<input type='hidden' name='slhienthi' value=" + PAGES_SHOW + ">";
            Response.Write("<div id='phantrang'>" + result + "</div>");
            Response.Write("<input type='hidden' name='dk' value='" + dk + "'>");
            comm.Dispose();
            reader.Dispose();
            conn.Close();
        }
        catch (Exception e)
        {
            Response.Write(url);
        }
    }
 %>
 <form id="Form1" runat =server>   
     
  
 </FORM>    
</asp:Content>

