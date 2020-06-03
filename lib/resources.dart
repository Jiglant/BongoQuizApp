const HOST_URL = "http://192.168.43.136:8000";
const LARAVEL_ECHO_HOST = "http://192.168.43.136:6003";

const REGISTER_ROUTE = "$HOST_URL/v1/register";
const LOGIN_ROUTE = "$HOST_URL/v1/login";


const API_EN_ROUTE = "$HOST_URL/v1/en/";

//Content Routes
const FAVORITE_ROUTE = "${API_EN_ROUTE}favorite/topic";
const NEW_TOPIC_ROUTE = "${API_EN_ROUTE}new/topic";
const TOPICS_ROUTE = "${API_EN_ROUTE}topics";
const CATEGORY_TOPICS_ROUTE = "${API_EN_ROUTE}category/";
const TOPIC_DETAILS_ROUTE = "${API_EN_ROUTE}topic/";

//Broadcasting route
const SEARCH_OPPONENT_ROUTE = "$HOST_URL/v1/search-opponent/";

const LANGUAGE = const {
  'Register': 'Sajili',
  'Log In': 'Ingia',
  'Email': 'Barua pepe',
  'Username': 'Jina',
  'name': 'Jina',
  "Username or Email":"Jina au Baruapepe",
  'Password': 'Neno la siri',
  'Confirm': 'Rudia',
  'Confirm password': 'Rudia neno la siri',
  'New User': 'Jisajili',
  "Username is required": "Jina linahitajika",
  "Username must be at least 4 characters":
      "Jina linatakiwa liwe na herufi kuanzia nne",
  "Email is required": "Baruapepe inahitajika",
  "Invalid email": "Baruapepe sio sahihi",
  "Password too short": "Neno la siri sio salama",
  "Password must match": "Neno la siri halifanani",
  "Invalid credentials'":"Taarifa sio sahihi",
  'Something went wrong':'Kuna tatizo kidogo',
  'New Topics':'Topiki Mpya',
  'Favorites':'Topiki Uzipendazo',
  'Topics':'Topiki',
  'Load More':'Zaid',
  "Random Opponent":"Mpinzani wa nasibu",
  "Random":"Nasibu",
  'Play with a friend':'Cheza na rafiki',
  'Waiting for Opponent':'Subiri mpinzani'

};

const TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYmI5ZWM0OTE5MTZiYjEzMjFhMGRkNGFkOWY2MjUyOGJmOGI0NzYyZWM0NjJkNzhiYWQ0NDI1MjljZjU1ODlkZTY5NTMzZTI3ZTM5Nzc3YjQiLCJpYXQiOjE1OTA3NTI4MTEsIm5iZiI6MTU5MDc1MjgxMSwiZXhwIjoxNjIyMjg4ODExLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.nUw6ABMK6S0JOy--UbxgEQScisPRUyTJaJwZvxUa2471y7cm69IVDzuFPfsxea2TiX88WVb-U5JKQEr2FWxfB56lcApUVnhciJ0ou6I3cdJI0_8gGYGb9Oeu4kkAC8cMHDby8ov0MQNV6gMlqrUvCEytZShVXZBSEZu2R-ctod7CkJS7yB19KNaq5W965hOK90TM3TAM8Y1zGcUpJL0_vUY9o4ACtR2e26jaVNY4n0MtkqH9Vl-b4HQVw9qne9oKJPf5ixXh-kDq2i6b2IJ7QnBd8xtvASeBpO4XQKBl-2wM-9JE8t7jmDH8AVq5kNEQaEqL68Fl02xEkxEkhyBRA9bAFyCQu0uS01KzcBUblBjQCKl4CPn_CqTBF_euGD3BTkuzSUsIX7h0PpMt8nNQXE6GLeO4aqxghngHHbajsnyw9Wn-SYN2uESFR04DlijQ4GtwLOZGh4Y3K4kGqYR8F_HEQUNfmnwIp-apW4x6MY9ugkSITC6gy0vJnf3ZCAENvWOKzLsvA1VbWpkx1DLYTn8l5EV0wfhgENPBE7A5MMNHbTiembv8GflC3ME6SCcpr8MxwtfagOchBkDVJLjw5ws43Zpjpc9noMy0xBVqMAxufijcYRVLhTrCR7UThIJQ0FxCbgJCdij2i9oqYYsZlkqZ_xbQFWw_wL7GTklsBa4";