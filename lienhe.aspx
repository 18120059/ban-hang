<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="lienhe.aspx.cs" Inherits="lienhe" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form name="lienhe" action="" method="post" onSubmit="return check(this);">
    <table width=100% cellspacing="0" cellpadding="0" border="0" class="Table" style="border-color:#0066FF" bgcolor =white>
      	<tr>
			<td height="40" align="center" valign="middle" background="images/ban.gif" class="tuabanner" >Liên hệ </td>
		</tr>
		<tr>
        	<td>
    			<table width="100%" border="0" cellpadding="4" cellspacing="0">
				
	 				<tr>
						<td width="130" align="right">Họ tên<font color="#FF0000">*</font></td>           
					  	<td><input maxlength=25 size=23 name="hoten" class="cell"> &nbsp;</td> 
					</tr>
					<tr>
						<td align="right">Địa chỉ</td>
						<td><textarea name="diachi" cols="20" rows="2" class="cell"></textarea>																									 					</tr>
					<tr>
					 	<td align="right">Điện thoại</td>
					 	<td><input name="phone" size="16" maxlength="10" class="cell">					 					</tr>
					<tr>
                        <td align="right">E-mail<font color="#FF0000">*</font></td>
                        <td><input maxlength=26 size=22 name="Email" class="cell">&nbsp;</td>
                    </tr>
					<tr>
						<td align="right">Tiêu đề<font color="#FF0000">*</font></td>
						<td><input maxlength=26 size=22 name="tieude" class="cell">&nbsp;</td>
					</tr>
					<tr>
						<td align="right">Nội dung liên hệ<font color="#FF0000">*</font></td>
						<td><textarea name="noidung" cols="35" rows="5" class="cell"></textarea>	
					</tr>
					<tr>
                             <td align="right">Mã xác nhận</td>
                             <td><input maxlength=10 size=10 name="ma" class="cell" >&nbsp;&nbsp;<span runat=server id=maxacnhan style="color:#0033FF;background-color:#ebe7f7">
							 
							 </span></td>
                    </tr>				
					<tr>
                          <td height="50" colspan="3" align="center"><input name="cmdDangky" type="submit" value="Xác nhận" />&nbsp;
                                   <input type=reset value="Nhập lại"></td>
                     </tr>
				</table>
			</td>
		</tr>
	</table>
	</form>
</asp:Content>

