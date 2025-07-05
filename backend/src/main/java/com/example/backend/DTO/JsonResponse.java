package com.example.backend.DTO;

public class JsonResponse<T> {
    private String message;
    private T data;

    public JsonResponse(String message) {
        this.message = message;
        this.data = null;
    }

    public JsonResponse(String message, T data) {
        this.message = message;
        this.data = data;
    }

    public JsonResponse() {
    }

    public String getMessage() {
        return message;
    }

    public T getData() {
        return data;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setData(T data) {
        this.data = data;
    }
}