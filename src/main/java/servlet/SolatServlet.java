package servlet;
import com.google.gson.Gson;

import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import java.time.LocalTime;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;

@WebServlet("/")
public class SolatServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response, "Johor", "1.474744", "103.740093");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String city = request.getParameter("city");

        if (city == null || city.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("City parameter is missing");
            return;
        }

        String latitude = null, longitude = null;
        System.out.println(city + ": city");
        
        switch (city) {
        case "Johor":
            latitude = "1.474744";
            longitude = "103.740093";
            break;
        case "Malacca":
            latitude = "2.1894";
            longitude = "102.2501";
            break;
        case "Kuala Lumpur":
            latitude = "3.139";
            longitude = "101.6869";
            break;
        case "Putrajaya":
            latitude = "2.929";
            longitude = "101.65";
            break;
        case "Penang":
            latitude = "5.4142";
            longitude = "100.3288";
            break;
        case "Selangor":
            latitude = "3.0739";
            longitude = "101.5183";
            break;
        case "Perak":
            latitude = "4.5934";
            longitude = "101.0916";
            break;
        case "Pahang":
            latitude = "3.9477";
            longitude = "102.159";
            break;
        case "Terengganu":
            latitude = "5.3356";
            longitude = "103.1438";
            break;
        case "Kelantan":
            latitude = "6.1256";
            longitude = "102.2366";
            break;
        case "Sarawak":
            latitude = "1.5533";
            longitude = "110.3596";
            break;
        case "Sabah":
            latitude = "5.9474";
            longitude = "116.0751";
            break;
        case "Labuan":
            latitude = "5.2801";
            longitude = "115.25";
            break;
        default:
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid city");
            return;
    }
        processRequest(request, response, city, latitude, longitude);
        
      }
    private void processRequest(HttpServletRequest request, HttpServletResponse response, String city, String latitude, String longitude) throws ServletException, IOException {
    	
    	LocalDate currentDate = LocalDate.now();
        String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
        
        String apiUrl = "https://api.aladhan.com/v1/timings/" + formattedDate + "?latitude=" + latitude + "&longitude=" + longitude + "&method=11";
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
          Scanner scanner = new Scanner(connection.getInputStream());
          StringBuilder response_content = new StringBuilder();
          while (scanner.hasNext()) {
            response_content.append(scanner.nextLine());
          }
          scanner.close();

          Gson gson = new Gson();
          JsonObject jsonObject = gson.fromJson(response_content.toString(), JsonObject.class);

          JsonObject dataObject = jsonObject.getAsJsonObject("data");
          JsonObject timings = dataObject.getAsJsonObject("timings");

          request.setAttribute("location", city + ", Malaysia");
          request.setAttribute("fajr", timings.get("Fajr").getAsString());
          request.setAttribute("dhuhr", timings.get("Dhuhr").getAsString());
          request.setAttribute("asr", timings.get("Asr").getAsString());
          request.setAttribute("maghrib", timings.get("Maghrib").getAsString());
          request.setAttribute("isha", timings.get("Isha").getAsString());
          
          String fajr = timings.get("Fajr").getAsString();
          String dhuhr = timings.get("Dhuhr").getAsString();
          String asr = timings.get("Asr").getAsString();
          String maghrib = timings.get("Maghrib").getAsString();
          String isha = timings.get("Isha").getAsString();
          
       // Add 10 minutes to Fajr time
          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
          LocalTime fajrTime = LocalTime.parse(fajr, formatter).plus(10, ChronoUnit.MINUTES);
          String adjustedFajr = fajrTime.format(formatter);

          request.setAttribute("location", city + ", Malaysia");
          request.setAttribute("fajr", adjustedFajr);
          request.setAttribute("dhuhr", dhuhr);
          request.setAttribute("asr", asr);
          request.setAttribute("maghrib", maghrib);
          request.setAttribute("isha", isha);
          
          
          
          // Get the current time and add it as request attributes
          LocalTime currentTime = LocalTime.now();
          DateTimeFormatter hourFormatter = DateTimeFormatter.ofPattern("HH");
          DateTimeFormatter minuteFormatter = DateTimeFormatter.ofPattern("mm");
          DateTimeFormatter secondFormatter = DateTimeFormatter.ofPattern("ss");
          request.setAttribute("currentHour", currentTime.format(hourFormatter));
          request.setAttribute("currentMinute", currentTime.format(minuteFormatter));
          request.setAttribute("currentSecond", currentTime.format(secondFormatter));

          request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else {
          response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
          response.getWriter().write("Error retrieving prayer times");
        }
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    
}