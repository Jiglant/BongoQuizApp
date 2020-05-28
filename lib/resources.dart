const HOST_URL = "http://192.168.43.136:8000";
const REGISTER_ROUTE = "$HOST_URL/v1/register";
const API_EN_ROUTE = "$HOST_URL/v1/en/";


const FAVORITE_ROUTE = "${API_EN_ROUTE}topic/favorite";
const NEW_TOPIC_ROUTE = "${API_EN_ROUTE}topic/new";
const TOPICS_ROUTE = "${API_EN_ROUTE}topic";

const LANGUAGE = const {
  'Register': 'Sajili',
  'Log In': 'Ingia',
  'Email': 'Barua pepe',
  'Username': 'Jina',
  'name': 'Jina',
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
  'New Topics':'Topiki Mpya',
  'Favorites':'Topiki Uzipendazo',
  'Topics':'Topiki'
};

const TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWRlMzVkODlmNzY1NGRkOTgwNTQ2YmFlZGEyOTRhNzEzNzY2MGM2NTViMTRiY2M5Y2E0MDNiYmUxODY0YTQ5MTQyODJiM2IwNTM3ZDg5NzYiLCJpYXQiOjE1ODk5NzY1OTcsIm5iZiI6MTU4OTk3NjU5NywiZXhwIjoxNjIxNTEyNTk3LCJzdWIiOiI1MSIsInNjb3BlcyI6W119.wLqF_SYk8yb8q370fOdQJq_jTCNj5qYP9ofmBQfDPCPjD5ODB_8bRCElrfO7W9UU6DZswebxvgBRaxnKwZJzPVyybQiwnGWLkKObp1RLuqTlnCkCoXXvGBB0qhxNo3uesijICOZ_ivBUiyxszxGbSbc-beDuUxlRssVY8xLJ0Y9xKLjpE7zzbhYtCtQ4zLKr0yCqJaDWGW64I5wNCclxqzuOA31C7EKLspH3sVR50ELLUFZI3_40b26HCq4k8LXmqTX_chf0Ebko9EqJu5d8YudrNsaewQ0yeed2b48XdP9oXu3TpsLfRMxFbhu98LI14IXB8AGzdG3vf9uBRrUwIrC9y95WqFXIHKs3lPeAhLa07jY5eav5vUqkAE2ro3Z7hq-jOBGh8uRi_I9kUzgTM1nsNGNHwe2bM5ux1i4G0W4zK76FJFSuCL5CjjZZQxUY56yduwh-eg1AZd8TDiI7uVdikeJSI8BOTUCTn1-WKXuw4kZxnQ_ApJGZX3VOIDKshQMkakzwSZXskfB-AwTpswdsCYBKUf9bIYx7v9JYcXS353EHH3V98oIVJHf_C9_Fexf_mBYNO9mR4GYU8uhqf3DPeE_NqpS90HAbCW7P1AibXy7-ONHEkh2w2pYL5XU8AO6RKSto95lfvAPKT5XV9aVX2vzlnmw8Zs1xMhulJvw";
