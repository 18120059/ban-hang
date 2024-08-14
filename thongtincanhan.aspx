<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="thongtincanhan.aspx.cs" Inherits="thongtincanhan" Title="Untitled Page" %>
<%@ Import Namespace="System.Data.SqlClient"%>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script language="javascript">
	function check(form)
	{
		
		var kt=new kiemtra();
		var tenkh=form.tenkhachhang.value;
		tenkh=kt.chuyendoi(tenkh);
		var diachi=form.diachi.value;
		diachi=kt.chuyendoi(diachi);
		var dienthoai=form.dienthoai.value;
		var namsinh=form.namsinh.value;
		var email=form.email.value;
		//alert (document.getElementById("error_email").innerHTML);
		//alert (email);
		var flag=true;
		if(flag)
			flag=kt.kieu(form.name,"tenkhachhang","Tên",tenkh,1,30);
		if(flag)
			flag=kt.kieu(form.name,"namsinh","Ngày sinh",namsinh,7,10);
		if(flag)
			flag=kt.kieu(form.name,"diachi","Địa chỉ",diachi,3,100);
		if(flag)
			flag=kt.kieu(form.name,"dienthoai","Điện thoại",dienthoai,5,15);
		if(flag)
			flag=kt.kieu(form.name,"email","Email",email,8,50);
		if(flag)
		    if(document.getElementById("error_email").innerHTML=="*")
			{
				alert ("Email " + email + " da co nguoi su dung");
				flag=false;
			}
		return flag;
	}
	function goback()
	{
		var link=document.getElementById("url").value;
		location.href=link;
	}
	function test(object)
    {
        document.getElementById("error_email").value="";
        var des=object.value;
        var sou=document.getElementById("mailsource").value;
        alert (sou);
        alert (des!=sou);
        var chk=new cls_check();
        if(des!=sou)
        {
            var link="ktra_dangky.aspx?email=" + des;
			chk.test(link,"error_email");
        }
    }
</script>
<% 
    if (Session["user"] != null && Request.QueryString["type"] != null)
    {
        string type = Request.QueryString["type"].ToString();
        string url = "";
        if (type.Equals("1"))
            url = "donhang.aspx";
        else if (type.Equals("2"))
            url = "hoantat.aspx";
        else
            url = "Default.aspx";
        string connectString = ConfigurationManager.ConnectionStrings["dotnet"].ConnectionString;
        string sql = "select * from thanhvien where username like '" + Session["user"].ToString() + "'";
        SqlConnection conn = new SqlConnection(connectString);
        conn.Open();
        //tao doi tuong thuc thi sql
        SqlCommand comm = new SqlCommand(sql, conn);
        SqlDataReader reader = comm.ExecuteReader();
        comm.Dispose();
        reader.Read();
        string result = "<table align='center' width='100%' bgcolor='#FFFFFF' border='1' class='Table_sp' cellspacing='0' cellpadding='0'>";
        result += "<tr bgcolor='#f9af3f' class='chucam'><th>Thông tin cá nhân</th></tr>";
        result += "<tr><td><table width='100%' border='0' cellspacing='2' cellpadding='0'>";
        result += "<form name='thongtincanhan' action='suathongtin.aspx' method='post' onsubmit='return check(this)'>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Tên khách hàng</td><td><input type='text' name='tenkhachhang' size='15' value='" + reader["tenkh"].ToString() + "' class='cell'></td></tr>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Ngày sinh</td><td><input type='text' name='namsinh' size='8' value='" + reader["namsinh"].ToString() + "' class='cell'></td></tr>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Địa chỉ</td><td><input type='text' name='diachi' size='30' value='" + reader["diachi"].ToString() + "' class='cell'></td></tr>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Điện thoại</td><td><input type='text' name='dienthoai' size='6' value='" + reader["dienthoai"].ToString() + "' class='cell'></td></tr>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Email</td><td><input type='text' name='email' size='15' value='" + reader["email"].ToString() + "' class='cell' onblur='test(this)'>&nbsp;<span id='error_email' style='color:red'></span><input type='hidden' name='mailsource' value='" + reader["email"].ToString() + "'></td></tr>";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Quốc gia</td><td><select name='quocgia' size='1' class='cell' onChange='disable(this.value)'>";
        string quocgia=reader["quocgia"].ToString();
        string tinh = reader["thanhpho"].ToString();
        reader.Dispose();
        comm.Dispose();
        sql = "select * from quocgia";
        comm = new SqlCommand(sql, conn);
        reader = comm.ExecuteReader();
        while (reader.Read())
            if (quocgia.Equals(reader["maquocgia"].ToString()))
                result += "<option value='" + reader["maquocgia"].ToString() + "' selected>" + reader["tenquocgia"].ToString() + "</option>";
            else
                result += "<option value='" + reader["maquocgia"].ToString() + "'>" + reader["tenquocgia"].ToString() + "</option>";
        result += "</select></td></tr>";
        sql = "select * from tinh";
        result += "<tr><td width='15'>&nbsp;</td><td style='font-size:13px' width='150'>Tỉnh/TP</td><td><select name='tinh' size='1' class='cell' onChange='disable(this.value)'>";
        reader.Dispose();
        comm.Dispose();
        comm = new SqlCommand(sql, conn);
        reader = comm.ExecuteReader();
        while (reader.Read())
            if (tinh.Equals(reader["matinh"].ToString()))
                result += "<option value='" + reader["matinh"].ToString() + "' selected>" + reader["tinh"].ToString() + "</option>";
            else
                result += "<option value='" + reader["matinh"].ToString() + "'>" + reader["tinh"].ToString() + "</option>";
        result += "</select></td></tr>";
        result += "<tr><td colspan='3' align='center'><input type='submit' name='cmdSuathongtin' value='Đồng ý'>&nbsp;<input type='button' value='Không' onclick='goback()'></td></tr><input type='hidden' name='url' value='" + url.ToString() + "'></form></table>";
        result += "</td></tr></table>";
        reader.Dispose();
        comm.Dispose();
        conn.Close();
        Response.Write(result);
    }
    else
        Response.Redirect("Default.aspx");
%>
</asp:Content>

