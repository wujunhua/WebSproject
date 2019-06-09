<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!doctype html>
<html lang="en">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<!-- Custom CSS -->
	<!--<link rel="stylesheet" href="css/login.css">-->
        <link rel="stylesheet" href="resources/css/login.css">
	<!-- Animate CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
	<!-- Google Fonts (Noto Sans) --> 
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">

	<title>Home</title>
        <style>
            p, h1, h2, h3, h4, h5, h6, li, ul, ol{
                font-family: Verdana,Geneva,sans-serif;
            }
        </style>
</head>
<body class="animated fadeIn">
	
    <div id="login"></div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.24.0/babel.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.4.2/react-dom.min.js"></script>
        
        
    <script src="<c:url value="/resources/js/form.js" />"></script>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>

<script type="text/babel">
    class Login extends React.Component {
        render() {
            return(
                    <div className="container-fluid h-100">
                        <div className="row justify-content-center align-items-center h-100">
                            <div className="col col-sm-6 col-md-6 col-lg-4 col-xl-6 card mx-2 py-5 animated fadeIn shadow-lg rounded-0">
				<div className="row justify-content-center">
					<div className="col-7">
                                               <img src="resources/img/logo.png" className="img-fluid" />
					</div>
				</div>

                                <p className="text-center text-danger">${errorMessage}</p>

				<s:form commandName="user" className="px-5 noto" id="login-form">
                                    <div className="input-group mb-3">
                                      <div className="input-group-prepend">
                                        <span className="input-group-text" id="basic-addon1"><i className="far fa-envelope"></i></span>
                                      </div>
                                      <input type="text" className="form-control-lg form-control" name="userName" placeholder="Email" aria-label="Email" aria-describedby="basic-addon1" />
                                    </div>
                                    <div className="input-group mb-2">
                                      <div className="input-group-prepend">
                                        <span className="input-group-text" id="basic-addon2"><i className="fas fa-lock"></i></span>
                                      </div>
                                      <input type="password" className="form-control-lg form-control" name="password" placeholder="Password" aria-label="Password" aria-describedby="basic-addon2" />
                                    </div>

                                    <small className="text-muted">
                                        <a id="myLink" href="reset-password.htm">Forgot Password?</a>
                                    </small>
                                    <div className="form-group text-center pt-2">
                                            <button type="submit" href="#" className="btn bg-primary text-white rounded-0 px-5">
                                                    <i className="fas fa-sign-in-alt pr-2"></i>Sign In
                                            </button>
					</div>
				</s:form>
                            </div>
                        </div>
                    </div>
            );
        }
    }
    
    ReactDOM.render(<Login />, document.getElementById('login'));
</script>