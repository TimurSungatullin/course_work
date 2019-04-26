package ru.itis.teamwork.services;

import lombok.Data;
import lombok.SneakyThrows;
import org.apache.http.HttpResponse;
import org.apache.http.NoHttpResponseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONArray;
import org.springframework.stereotype.Service;
import org.springframework.web.util.UriBuilder;
import ru.itis.teamwork.util.githubApi.GitHubApi;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@Service
@Data
public class TelegramService {

    private String host;
    private Integer port;
    private URIBuilder uriBuilder;

    public TelegramService(String host, Integer port)  {
        this.host = host;
        this.port = port;

        try {
            this.uriBuilder = new URIBuilder(this.host);
        } catch (URISyntaxException e) {
            System.out.println(e);
        }
        this.uriBuilder.setPort(this.port);

    }


    public Optional<Boolean> isConnectedUser(String phone) throws URISyntaxException, IOException {
        uriBuilder.setPath("/connect");
        HttpPost httpPost = new HttpPost(uriBuilder.build());
        httpPost.addHeader("Content-Type", "application/json");

        StringEntity stringEntity = new StringEntity("{\"phone\":\"" + phone + "\"}");
        httpPost.setEntity(stringEntity);
        HttpClient httpClient = HttpClients.createDefault();
        try {
            HttpResponse response = httpClient.execute(httpPost);

            if (response.getStatusLine().getStatusCode() == 200) {
                JSONArray jsonArray = GitHubApi.getJsonResp(response);
                return Optional.of(jsonArray.getJSONObject(0).getBoolean("is_connected"));
            }

        } catch (IOException e){
            return Optional.empty();
        }


        return Optional.empty();
    }

    public Optional<Boolean> sendCode(String phone, String code) throws IOException, URISyntaxException {
        uriBuilder.setPath("/sign");
        HttpPost httpPost = new HttpPost(uriBuilder.build());
        httpPost.addHeader("Content-Type", "application/json");

        StringEntity stringEntity = new StringEntity("{\"phone\":\"" +
                phone + "\",\"code\":\"" + code + "\"}");
        httpPost.setEntity(stringEntity);
        HttpClient httpClient = HttpClients.createDefault();
        try {
            HttpResponse response = httpClient.execute(httpPost);

            if (response.getStatusLine().getStatusCode() == 200) {
                JSONArray jsonArray = GitHubApi.getJsonResp(response);
                return Optional.of(jsonArray.getJSONObject(0).getBoolean("is_connected"));

            } else {
                return Optional.of(false);
            }

        } catch (IOException e){
            return Optional.empty();
        }

    }

    public Optional<Long> createChat(List<String> membersPhone, String creatorPhone, String title) throws URISyntaxException, UnsupportedEncodingException {
        uriBuilder.setPath("/create_chat");
        HttpPost httpPost = new HttpPost(uriBuilder.build());
        httpPost.addHeader("Content-Type", "application/json");

        StringEntity stringEntity = new StringEntity("{\"phone\":\"" +
                creatorPhone + "\",\"members\":\"" + membersPhone.toString() + "\",\"title\":\"" + title + "\"}");
        httpPost.setEntity(stringEntity);
        HttpClient httpClient = HttpClients.createDefault();
        try {
            HttpResponse response = httpClient.execute(httpPost);

            if (response.getStatusLine().getStatusCode() == 200) {
                JSONArray jsonArray = GitHubApi.getJsonResp(response);
                Long chat_id = jsonArray.getJSONObject(0).getLong("chat_id");
                return Optional.of(chat_id);
            }

        } catch (IOException e) {
            return Optional.empty();
        }
        return Optional.empty();

    }


}
