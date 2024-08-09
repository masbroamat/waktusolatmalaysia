<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%
    if (request.getAttribute("location") == null) {
        request.getRequestDispatcher("/city").forward(request, response);
        return;
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Waktu Solat Malaysia</title>
    <link rel="icon" href="./images/favicon.png" type="image/png">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,1,0" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="./css/styles.css">
</head>
<body>
	<div class="overlay" id="overlay">
		Waktu Solat
		<br>
		<div class="location">
            <span class="material-symbols-outlined">
                location_on
            </span>
            ${requestScope.location}
        </div>
	</div>
    <div class="main">
        <div class="main-content">
            <div class="heading">
                <h1>Waktu Solat Malaysia</h1>
            </div>
            <div class="title">
                <div class="location">
                    <span class="material-symbols-outlined">
                        location_on
                    </span>
                    <span>${requestScope.location}</span>
                </div>
                <div class="filter">
                    <form action="city" method="post" id="solatForm">
					    <div class="inputcontainer">
						    <div class="firstrow">
						        <div class="inputlabel">
						            Filter By State
						        </div>
						        <div class="inputselect">
						           	<select name="city" id="city">
									    <option value="Johor" ${requestScope.location.contains("Johor") ? "selected" : ""}>Johor</option>
									    <option value="Malacca" ${requestScope.location.contains("Malacca") ? "selected" : ""}>Malacca</option>
									    <option value="Kuala Lumpur" ${requestScope.location.contains("Kuala Lumpur") ? "selected" : ""}>Kuala Lumpur</option>
									    <option value="Putrajaya" ${requestScope.location.contains("Putrajaya") ? "selected" : ""}>Putrajaya</option>
									    <option value="Penang" ${requestScope.location.contains("Penang") ? "selected" : ""}>Penang</option>
									    <option value="Selangor" ${requestScope.location.contains("Selangor") ? "selected" : ""}>Selangor</option>
									    <option value="Perak" ${requestScope.location.contains("Perak") ? "selected" : ""}>Perak</option>
									    <option value="Pahang" ${requestScope.location.contains("Pahang") ? "selected" : ""}>Pahang</option>
									    <option value="Terengganu" ${requestScope.location.contains("Terengganu") ? "selected" : ""}>Terengganu</option>
									    <option value="Kelantan" ${requestScope.location.contains("Kelantan") ? "selected" : ""}>Kelantan</option>
									    <option value="Sarawak" ${requestScope.location.contains("Sarawak") ? "selected" : ""}>Sarawak</option>
									    <option value="Sabah" ${requestScope.location.contains("Sabah") ? "selected" : ""}>Sabah</option>
									    <option value="Labuan" ${requestScope.location.contains("Labuan") ? "selected" : ""}>Labuan</option>
									</select>
						        </div>
						    </div>
						    <div class="secondrow">
						        <div class="inputbutton">
						            <button type="submit">
						                <span class="material-symbols-outlined">
						                    keyboard_arrow_right
						                </span>
						            </button>
						        </div>
					        </div>
					    </div>
					</form>
                </div>
                <div class="waktusolatsekarang">
                    <span class="material-symbols-outlined">
                        bedtime
                    </span>
                    ${requestScope.currentPrayer}
                </div>
            </div>
            <div class="clock">
                <div class="clockmain">
                    <div class="clockcontainer">
                        <div class="clocknumber" id="currentHour">
                            ${requestScope.currentHour}
                        </div>
                        <div class="clocktext">
                            HOURS
                        </div>
                    </div>

                    <div class="colon">:</div>

                    <div class="clockcontainer">
                        <div class="clocknumber" id="currentMinute">
                            ${requestScope.currentMinute}
                        </div>
                        <div class="clocktext">
                            MINUTES
                        </div>
                    </div>
                    
                    <div class="colon">:</div>
                    
                    <div class="clockcontainer">
                        <div class="clocknumber" id="currentSecond">
                            ${requestScope.currentSecond}
                        </div>
                        <div class="clocktext">
                            SECONDS
                        </div>
                    </div>
                </div>
                <div class="clocksub">
                    <div class="clockcontainer">
                        <div class="clocknumber">
                            ${requestScope.fajr}
                        </div>
                        <div class="clocktext">
                            FAJR
                        </div>
                    </div>
                    <div class="clockcontainer">
                        <div class="clocknumber">
                            ${requestScope.dhuhr}
                        </div>
                        <div class="clocktext">
                            DHUHR
                        </div>
                    </div>
                    <div class="clockcontainer">
                        <div class="clocknumber">
                            ${requestScope.asr}
                        </div>
                        <div class="clocktext">
                            ASR
                        </div>
                    </div>
                    <div class="clockcontainer">
                        <div class="clocknumber">
                            ${requestScope.maghrib}
                        </div>
                        <div class="clocktext">
                            MAGHRIB
                        </div>
                    </div>
                    <div class="clockcontainer">
                        <div class="clocknumber">
                            ${requestScope.isha}
                        </div>
                        <div class="clocktext">
                            ISHA
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="background parallax"></div>
        <div class="copyrightleft">
            <div class="logo"><a href="/"><i class="fa-solid fa-kiwi-bird"></i></a></div>
            <div class="socials">
                <a href="#"><i class="fab fa-github"></i></a>
                <a href="#"><i class="fab fa-linkedin"></i></a>
            </div>
            <div class="author">&copy; 2024 masbro</div>
        </div>
        <div class="copyrightright">
            <a href="https://aladhan.com/prayer-times-api" target="_blank"><div class="apicredit">API</div></a>
        </div>
    </div>
    <script src="./js/script.js"></script>
</body>
</html>