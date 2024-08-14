<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="giohang.aspx.cs" Inherits="giohang" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript">
	function sua(object)
	{
		var name=object.name
		var maso=name.substring(3);
		//alert (maso);
		var soluong=eval("document.getElementById('txt" + maso + "').value");
		//alert (soluong);
		var masp=document.getElementById('maspsua').value;
		var sluong=document.getElementById('slsua').value;
		if(masp=="" && sluong=="")
		{
			document.getElementById('maspsua').value=maso + ";";
			document.getElementById('slsua').value=soluong + ";";
		}
		else
		{
			var tam_sp=masp.split(";");
			var tam_sl=sluong.split(";");
			var flag=false;//kiem tra san pham them vao da co trong danh sach chua
			masp="";//bien mang luu danh sach san pham sau khi da duoc them
			sluong="";//bien mang luu so luong tuong ung cua tung san pham
			for(i=0;i<tam_sp.length-1;i++)
			{
				if(maso==tam_sp[i])
				{
					tam_sl[i]=soluong;
					flag=true;
				}
				masp+=tam_sp[i] + ";";
				//alert (masp);
				sluong+=tam_sl[i] + ";";
				//alert (sluong);
			}
			if(!flag)//san pham them vao chua co trong danh sach->them vao danh sach san pham
			{
				masp+=maso + ";";
				sluong+=soluong + ";";
			}
			document.getElementById('maspsua').value=masp;
			document.getElementById('slsua').value=sluong;
		}
		//alert (document.getElementById('maspsua').value);
		//alert (document.getElementById('slsua').value);
		return true;
	}
	function xoa()
	{
		var i;
		var dem=0;
		sanpham.xoasp.value="";
		if(sanpham.chk.length)
		{
			var total=sanpham.chk.length;
			for(i=0;i<total;i++)
				if(sanpham.chk[i].checked==true)
				{
					dem++;
					if(sanpham.xoasp.value=="")
						sanpham.xoasp.value+=sanpham.chk[i].value;
					else
						sanpham.xoasp.value+=";" + sanpham.chk[i].value;
				}
		}
		else
			if(sanpham.chk.checked==true)
			{
				sanpham.xoasp.value+=sanpham.chk.value;
			}
		//alert (sanpham.xoasp.value);
	}
	function check(form)
	{
		var kt=new kiemtra();
		var flag;
		if(form.chk.length)
		{
			var total=form.chk.length;
			for(i=0;i<total;i++)
			{
				var giatri=eval("document.getElementById('txt" + sanpham.chk[i].value + "').value");
				flag=kt.kieu(form.name,"txt" + sanpham.chk[i].value,"Giá trị",giatri,5,5);
				if(flag)
					if(giatri<=0)
					{
						alert ("Giá trị nhập không được nhỏ hơn 0");
						eval("sanpham.txt" + sanpham.chk[i].value + ".focus()");
						flag=false;
					}
				if(!flag)
					return flag;
			}
		}
		else
		{
			var giatri=eval("document.getElementById('txt" + sanpham.chk.value + "').value");
			var flag=kt.kieu(form.name,"txt" + sanpham.chk.value,"Giá trị",giatri,5,5);
			if(flag)
				if(giatri<=0)
				{
					alert ("Giá trị nhập không được nhỏ hơn 0");
					eval("sanpham.txt" + sanpham.chk.value + ".focus()");
					flag=false;
				}
			if(!flag)
				return flag;
		}
		return true;
	}
</script>
<% 
    string result="";
    if (Session["giohang"] == null || Session["giohang"].ToString().Equals("0"))
    {
        result = "<h3>Không có sản phẩm nào trong giỏ hàng</h3>";
        Response.Write(result);
    }
    else
    {
        int len = Session["sanpham"].ToString().Split(';').Length - 1;//trong qua trinh noi luon noi them 1 san pham rong phia sau->loai bo san pham co ma rong
        string[] mangsp = Session["sanpham"].ToString().Split(';');
        string[] mangsl = Session["sl"].ToString().Split(';');
        string dk = "";
        string[] sluong = new string[1000];
        for (int i = 0; i < len; i++)
        {
            string tam = mangsp[i];
            tam = tam.Substring(2);
            int index = int.Parse(tam.ToString());
            sluong[index] = mangsl[i];
            //Response.Write(sluong[index].ToString());
            if (dk == "")
                dk = "('" + mangsp[i] + "'";
            else
                dk += ",'" + mangsp[i] + "'";
        }
        dk += ")";
        string sql = "select * from sanpham where masp in " + dk + " order by masp";
        //Response.Write(sql);
        string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        SqlConnection conn = new SqlConnection(connectString);
        conn.Open();
        SqlCommand comm;
        SqlDataReader reader;
        try
        {
            comm = new SqlCommand(sql, conn);
            reader = comm.ExecuteReader();
            result = "<form name='sanpham' action='capnhatgiohang.aspx' method='post' onsubmit='return check(this)'>";
            result += "<table width='100%' bgcolor='#CCCCCC' cellspacing='0' cellpadding='0' border='1' class='Table_sp'>";
            result += "<tr bgcolor='#f9af3f' class='chucam'><th>Tên sản phẩm</th><th>Mô tả</th><th>Số lượng</th><th>Giá tiền</th><th>Xoá</th></tr>";
            int tongtien = 0;
            string chitiet = "";
            while (reader.Read())
            {
                string tam = reader["masp"].ToString();
                tam = tam.Substring(2);
                int index = int.Parse(tam.ToString());
                int giaban = int.Parse(sluong[index].ToString()) * int.Parse(reader["gia"].ToString());
                tongtien += giaban;
                chitiet += reader["masp"].ToString() + "-" + sluong[index].ToString() + "-" + giaban.ToString() + ";";
                result += "<tr>";
                result += "<td>" + reader["tensp"].ToString() + "</td>";
                result += "<td>" + reader["mota"].ToString() + "</td>";
                result += "<td align='center'><input type='text' size='1' class='cell' name='txt" + reader["masp"].ToString() + "' onblur='return sua(this)' value='" + sluong[index] + "' style='text-align:center'></td>";
                result += "<td align='right'>" + tien.tiente.chuyendoi(giaban.ToString()) + "</td>";
                result += "<td align='center'><input type='checkbox' name='chk' value='" + reader["masp"].ToString() + "' onclick='xoa()'></td>";
                result += "</tr>";
            }
            Session["tongtien"] = tongtien.ToString();
            Session["chitiet"] = chitiet;
            Session["tongsanpham"] = len.ToString();
            Session["hople"] = true;
            result += "<tr><td colspan='5' align='center'>Tổng cộng:&nbsp;<font color='red'>" + tien.tiente.chuyendoi(tongtien.ToString()) + " VND</td></tr>";
            result += "</table>";
            result += "<table width='100%' bgcolor='#FFFFFF' cellspacing='3' cellpadding='0' border='0'>";
            result += "<tr><td><a href='" + Session["url"].ToString() + "' class='thoat'>Tiếp tục mua hàng</a>&nbsp;&nbsp;";
            result += "<input type='submit' value='Cập nhật' name='cmdCapnhat'>";
            result += "<input type='hidden' name='xoasp'>";
            result += "<input type='hidden' name='maspsua'>";
            result += "<input type='hidden' name='slsua'>";
            result += "</td></tr></form><tr><td align='right'><form action='donhang.aspx' method='post'>";
            result += "<input type='submit' value='Tiếp tục' name='cmdTiep'>";
            result += "</form></td></tr></table>";
            Response.Write(result);
            //Response.Write(Session["tongtien"].ToString());
            //Response.Write(Session["chitiet"].ToString());
            //Response.Write(Session["tongsanpham"].ToString());
        }
        catch (Exception e)
        {
            Response.Write(Session["sanpham"].ToString());
            Response.Write(Session["sl"].ToString());
            Response.Write(sql);
        }
    }
%>
</asp:Content>

