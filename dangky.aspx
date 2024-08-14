<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dangky.aspx.cs" Inherits="dangky" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<form name="dangky" action="signin.aspx" method="post" onSubmit="return check_dk(this)">
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="Table" style="border-color:#0066FF" bgcolor=white>
      	<tr>
			<td class="tuabanner" height="40" align="center" valign="middle" background="images/ban.gif">Đăng Ký</td>
		</tr>
		<tr>
        	<td>
    			<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF">
				
	 				<tr>
						<th colspan="2">Thông tin cá nhân</th>
					</tr>
					<tr>
	  					<td width="130" align="right">Họ tên</td>           
					  	<td><input maxlength=40 size=23 name="hoten" class="cell"> &nbsp;</td>  																						  					</tr>
					<tr>
						<td align="right">Ngày sinh</td>
						<td class="chuthich"><input maxlength=10 size=16 name="ngaysinh" class="cell"> (dd/mm/yyyy)</td>
					</tr>
					<tr>
                              <td align="right">Giới tính</td>
                              <td>
                                    <select name="sex" class="cell">
                                      <option value="nam">Nam</option>
                                      <option value="nu">Nữ</option>
                                    </select> </td>
                     </tr>
					 <tr>
					 			<td align="right">Điện thoại</td>
					 <td><input name="phone" size="16" maxlength="12" class="cell">					 					</tr>
					<tr>
						<td align="right">Địa chỉ</td>
					<td><textarea name="diachi" cols="20" rows="2" class="cell"></textarea>																									 					</tr>
					<tr>
						<td align="right">Quốc gia</td>
						<td><select name="quocgia" size="1" class="cell" onChange="disable(this.value)">
							<option value="">--Select--</option>						
							<option value="ar">Argentina</option>							
							<option value="au">Australia</option>						
							<option value="bo">Bolivia</option>
							<option value="br">Brazil</option>
							<option value="bn">Brunei</option>
							<option value="ca">Canada</option>		
							<option value="cl">Chile</option>
							<option value="cn">China</option>							
							<option value="co">Colombia</option>					
							<option value="cu">Cuba</option>				
							<option value="eg">Egypt</option>			
							<option value="fi">Finland</option>
							<option value="fr">France</option>		
							<option value="ge">Germany</option>	
							<option value="hk">Hong Kong</option>
							<option value="hu">Hungary</option>				
							<option value="in">India</option>
							<option value="id">Indonesia</option>
							<option value="ir">Iran</option>
							<option value="iq">Iraq</option>
							<option value="ie">Ireland</option>	
							<option value="it">Italy</option>						
							<option value="jp">Japan</option>						
							<option value="la">Laos</option>						
							<option value="mo">Macau</option>					
							<option value="my">Malaysia</option>
							<option value="mx">Mexico</option>
							<option value="mm">Myanmar</option>
							<option value="nz">New Zealand</option>								
							<option value="kp">North Korea</option>
							<option value="ph">Philippines</option>								
							<option value="qa">Qatar</option>								
							<option value="ru">Russia</option>	
							<option value="sg">Singapore</option>	
							<option value="kr">South Korea</option>
							<option value="es">Spain</option>							
							<option value="se">Sweden</option>
							<option value="ch">Switzerland</option>							
							<option value="tw">Taiwan</option>							
							<option value="th">Thailand</option>								
							<option value="tr">Turkey</option>								
							<option value="uk">United Kingdom</option>
							<option value="us">United States</option>
							<option value="uz">Uzbekistan</option>						
							<option value="ve">Venezuela</option>
							<option value="vn">Vietnam</option>	
							</select></td>
					</tr>
					<tr>
						<td align="right">Tinh/TP</td>
						<td><select name="tinh" size="1" class="cell">
								<option value="">--Select--</option>
								<option value="ANG">An Giang</option>						  
								<option value="BRVT">Bà Rịa -Vũng Tàu</option>								  <option value="BAC">Bắc Cạn</option>				
								<option value="BAG">Bắc Giang</option>				
						 		<option value="BAL">Bạc Liêu</option>				
						  		<option value="BAN">Bắc Ninh</option>				
						  		<option value="BTR">Bến Tre</option>				
						  		<option value="BDH">Bình Định</option>				
						  		<option value="BDG">Bình Dương</option>				
						  		<option value="BPC">Bình Phước</option>				
						  		<option value="BTN">Bình Thuận</option>				
						  		<option value="CMA">Cà Mau</option>				
						  		<option value="CTH">Cần Thơ</option>				
						  		<option value="CBG">Cao Bằng</option>				
						  		<option value="DNA">Đà Nẵng</option>				
						  		<option value="DLC">Đắc Lắc</option>				
						  		<option value="DNO">Đắc Nông</option>				
						  		<option value="DBN">Điện Biên</option>				
						  		<option value="DGN">Đồng Nai</option>				
						  		<option value="DTP">Đồng Tháp</option>				
						  		<option value="GIL">Gia Lai</option>				
						  		<option value="HAG">Hà Giang</option>				
						  		<option value="HNA">Hà Nam</option>				
						  		<option value="HN">Hà Nội</option>				
						  		<option value="HTY">Hà Tây</option>				
						  		<option value="HTN">Hà Tĩnh</option>				
						  		<option value="HDG">Hải Dương</option>				
						  		<option value="HPG">Hải Phòng</option>				
						  		<option value="HAUG">Hậu Giang</option>				
						  		<option value="HCM">Hồ Chí Minh</option>				
						  		<option value="HOB">Hòa Bình</option>				
						  		<option value="HYN">Hưng Yên</option>				
						  		<option value="KHO">Khánh Hòa</option>				
						  		<option value="KGI">Kiên Giang</option>				
						  		<option value="KTU">Kon Tum</option>				
								<option value="LACH">Lai Châu</option>				
						  		<option value="LAD">Lâm Đồng</option>				
						  		<option value="LAS">Lạng Sơn</option>				
						  		<option value="LACA">Lào Cai</option>				
						  		<option value="LGA">Long An</option>				
						  		<option value="NAD">Nam Định</option>				
						  		<option value="NGA">Nghệ An</option>				
						        <option value="NIB">Ninh Bình</option>				
						  		<option value="NIT">Ninh Thuận</option>				
						  		<option value="PHT">Phú Thọ</option>				
						  		<option value="PHY">Phú Yên</option>				
						  		<option value="QBI">Quảng Bình</option>				
						  		<option value="QNA">Quảng Nam</option>				
						  		<option value="QNG">Quảng Ngãi</option>				
						  		<option value="QNI">Quảng Ninh</option>				
						  		<option value="QTR">Quảng Trị</option>				
						  		<option value="STR">Sóc Trăng</option>				
						  		<option value="SLA">Sơn La</option>				
						  		<option value="TAN">Tây Ninh</option>				
						  		<option value="THB">Thái Bình</option>				
						  		<option value="TNG">Thái Nguyên</option>				
						  		<option value="THO">Thanh Hóa</option>				
						  		<option value="TTH">Thừa Thiên Huế</option>				
						  		<option value="TIG">Tiền Giang</option>				
						  		<option value="TRV">Trà Vinh</option>				
						  		<option value="TUQ">Tuyên Quang</option>				
						  		<option value="VLG">Vĩnh Long</option>				
						  		<option value="VPC">Vĩnh Phúc</option>				
						  		<option value="YBA">Yên Bái</option>	
							</select></td>
					</tr>
					<tr>
						<th colspan="2" align="center">Thông tin bảo mật </th>
					</tr>
					<tr>
						<td align="right">Câu hỏi bí mật</td>
						<td><select name="cauhoi" size="1" class="cell">
								<option value="">--Select--</option>
								<option value="1">Tên bạn gái đầu tiên?</option>
								<option value="2">Ngày sinh của bạn gái?</option>
								<option value="3">Nụ hôn đầu tiên với ai?</option>
								<option value="4">Lần đầu tiên nắm tay ở đâu?</option>
								<option value="5">Tên con vật yêu quý?</option>
								<option value="6">Tên trường học đầu tiên?</option>
								<option value="7">Ước mơ tương lai là gì?</option>
							</select></td>
					</tr>
					<tr>
							<td align="right">Câu trả lời</td>                 			  
							<td><input maxlength=40 size=23 name="cauTL" class="cell">&nbsp;</td>
					</tr>
					<tr>
						<th colspan="2" align="center">Thông tin đăng nhập</th>
					</tr>					
					<tr>
							<td align="right">Tên user</td>	  
							<td><input maxlength=30 size=23 name="user" class="cell" onblur="check_reg(this)">&nbsp;<span id="error_user" style="color:red">
							</span>  </td>               		
					</tr>
					<tr>
							<td align="right">Password</td>                 			  
					  <td class="chuthich"><input type=password maxlength=20 size=16 name="pass" class="cell">&nbsp;(6-20 ký tự)</td>
					</tr>
					<tr>
                            <td align="right">Re-password</td>
                            <td><input type=password maxlength=20 size=16 name="repass" class="cell">&nbsp;</td>
                     </tr>
                     <tr>
                             <td align="right">E-mail</td>
                             <td><input maxlength=50 size=22 name="Email" class="cell" onblur="check_reg(this)">&nbsp;<span id="error_email" style="color:red">
							</span>  </td>
                    </tr>	
					<tr>
                             <td align="right">Mã xác nhận</td>
                             <td><input maxlength=10 size=10 name="ma" class="cell" >&nbsp;&nbsp;<span id=maxacnhan style="color:#0033FF;background-color:#ebe7f7">
							 <%
                                 string[] mang ={ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
                                 string ketqua = "";
                                 Random random = new Random();
                                 for (int i = 0; i < 6; i++)
                                 {
                                     int index=random.Next(0,35); 
                                     ketqua += mang[index];
                                 }
                                 Response.Write(ketqua);				     				     
							 %>
							 </span></td>
                    </tr>				
                     <tr>
                              <td height="50" colspan="3" align="center"><input name="cmdDangky" type="submit" value="Xác nhận"/>&nbsp;
                                   <input type=reset value="Nhập lại"></td>
                      </tr>
                      <% 
                          string url="";
                          if(Request.QueryString["type"]!=null)
                              if (Request.QueryString["type"].ToString() == "1")
                              {
                                  url = "donhang.aspx";
                                  Response.Write("<input type='hidden' name='url' value='" + url + "'>");
                              }
                      %>
                  </table>
			</td>
		</tr>
		</table>
	</form>
</asp:Content>

