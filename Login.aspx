<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> TrackIn </title>

    <link href="../Content/Styles/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Styles/Site.css" rel="stylesheet" />
    <link href="../Content/Styles/WeCare.css" rel="stylesheet" />
    <link href="../css/bootstrap.min.css" rel="stylesheet"/>
	<link href="../css/bootstrap-responsive.min.css" rel="stylesheet"/>
	<link href="../css/style.css" rel="stylesheet"/>
	<link href="../css/style-responsive.css" rel="stylesheet"/>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&subset=latin,cyrillic-ext,latin-ext' rel='stylesheet' type='text/css'/>
  
</head>
<body>
    <form runat="server">
        <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
        <script src="../Scripts/bootstrap.js" type="text/javascript"></script>
        <script src="../Scripts/bootstrap.min.js" type="text/javascript"></script>
        <script src="../Scripts/WeCare.js" type="text/javascript"></script>

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" runat="server"> TrackIn </a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right" runat="server">
                               <li class="navbar-text">
                                   <asp:Label ID="WelcomeLabel" runat="server" Text=""></asp:Label>
                               </li>
                            
                            <li class="navbar-text"><span class="glyphicon glyphicon-log-out"></span></li>
                             <%--  <li class="nav-text">
                                    <asp:LoginStatus ID="LoginStatus1" runat="server" OnLoggedOut="LoginStatus1_LoggedOut" LogoutAction="Redirect" LogoutPageUrl="~/Login.aspx"/>
                               </li>--%>
                            </ul>
                </div>
            </div>
        </div>
    
        <div class="container body-content" style="overflow:hidden">
        &nbsp;<br />
            <br />
            <br />
            <div class="main">
                &nbsp;&nbsp;&nbsp;<br />
                <br />
                <asp:Login ID="Login1" runat="server" DestinationPageUrl="Home.aspx" PasswordRecoveryText="Forgot password?" PasswordRecoveryUrl="ForgotPassword.aspx" BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" BorderPadding="4" ForeColor="#333333" Height="241px" Width="447px">
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                <TextBoxStyle Font-Size="0.8em" />
                <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="#FFFFFF" Font-Size="0.9em" />
                </asp:Login> &nbsp;<img src="Content/Images/Inventory.jpg" style="height: 409px; width: 378px" />
                <br />
                &nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <footer class="navbar-fixed-bottom">
                <p>&copy; <%: DateTime.Now.Year %> -TrackIn</p>
            </footer>
        </div>
    </form>
</body>
</html>




<%--  
<div>
    <form>
          <asp:Login ID="Login1" runat="server" CreateUserText="Register here" CreateUserUrl="Register.aspx" DestinationPageUrl="Home.aspx" PasswordRecoveryText="Forgot password?" PasswordRecoveryUrl="ForgotPassword.aspx"></asp:Login>
    </form>
</div>--%>

