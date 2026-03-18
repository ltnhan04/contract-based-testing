// jest-dom adds custom jest matchers for asserting on DOM nodes.
// allows you to do things like:
// expect(element).toHaveTextContent(/react/i)
// learn more: https://github.com/testing-library/jest-dom
import "@testing-library/jest-dom";
import axios from "axios";
import httpAdapter from "axios/lib/adapters/http.js";

// In jsdom, Axios may pick XHR and trigger CORS preflight; force Node HTTP adapter for Pact tests.
axios.defaults.adapter = httpAdapter;
