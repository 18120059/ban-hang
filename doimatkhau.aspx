<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="doimatkhau.aspx.cs" Inherits="doimatkhau" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--Download source code tai Sharecode.vn--%>
<script language="javascript">
    function kiemtra_doimk(form)
    {
        var passcu=form.txtpasscu;
        var passmoi=form.txtpassmoi
        var repass=form.txtrepass;
        //alert (passcu.value);
        //alert (passmoi.value);
        //alert (repass.value);
        var chk=new kiemtra();
        var flag=true;
        if(flag)
            flag=chk.kieu(form.name,"txtpasscu","Password",passcu.value,10,20);
        if(flag)
            flag=chk.kieu(form.name,"txtpassmoi","Password",passmoi.value,10,20);
        if(passmoi.length<6)
        {
            alert ("Password phai chua it nhat 6 ky tu");
            flag=false;
        }
        if(flag)
            if(passmoi.value!=repass.value)
            {
                alert ("Hai o password phai giong nhau");
                flag=false;
            }
        return flag;
    }
</script>
<form name="doimk" onsubmit="return kiemtra_doimk(this)" method="post" action="doimatkhau.aspx">
    <table width="350" align="center" bgcolor="white" class="Table_sp" cellspacing="3" cellpadding="0">
        <tr>
            <td class="chucam" colspan="2">
                Đổi mật khẩu
            </td>
        </tr>
        <tr>
            <td width="100" align="left">
                Password cũ:
            </td>
            <td>
                <input type="password" name="txtpasscu" size="10" class="cell"/>
            </td>
        </tr>
        <tr>
            <td align="left">
                Password mới:
            </td>
            <td>
                <input type="password" name="txtpassmoi" size="10" class="cell"/>(6-20 ký tự)
            </td>
        </tr>
        <tr>
            <td align="left">
                Nhập lại password:
            </td>
            <td>
                <input type="password" name="txtrepass" size="10" class="cell"/>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <input type="submit" value="Đổi mật khẩu" name="doi"/>
            </td>
        </tr>
        <% 
            if (Session["ketqua"] != null)
                if((int)Session["ketqua"]==0)
                    Response.Write("<tr><td colspan='2' align='center' class='sanpham'>Nhập sai password hiện hành</td></tr>");
                else
                {
                    Response.Write("<tr><td colspan='2' align='center' class='sanpham'>Thay đổi password thành công</td></tr>");
                }
            Session["ketqua"] = null;
        %>
    </table>
</form>
</asp:Content>

