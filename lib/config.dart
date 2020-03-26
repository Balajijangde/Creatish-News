const baseurl = "https://mishrakimirchi.com";
const api = "/wp-json/wp/v2";
const posts = "/posts";
const embed = "?_embed";
const posts_list_fields = "&_fields=id,date,modified,link,title,_embedded.wp:featuredmedia";
const phImage = "images/newsplaceholder.png";
const List demoNews = [
  {
    "title":"Corona patients reached high numbers",
    "excerpt":"corona virus is not going to stop on its own said by modi",
    "date": "23 March 2020",
    "image": "https://cdn.cnn.com/cnnnext/dam/assets/200130165125-corona-virus-cdc-image-super-tease.jpg"
  },
  {
    "title":"India again wins final world cup 🏆",
    "excerpt":"India is the winner of the world cup finals again in 2020",
    "date": "20 March 2020",
    "image": "https://specials-images.forbesimg.com/imageserve/1161194037/960x0.jpg"
  },
  {
    "title":"Amazon forest got forest fire today 🔥",
    "excerpt":"amazon forests got fired animals are shouting all around in the forest",
    "date": "20 March 2020",
    "image": "https://images.edexlive.com/uploads/user/imagelibrary/2019/8/22/original/Amozon-forest-fire-Web-1-760x00.jpg"
  },
  {
    "title":"Creatish is now global development and animation limited 🍻",
    "excerpt":"now creatish.in is incharge of every internet and graphics work in India",
    "date": "20 March 2020",
    "image": "https://ssir.org/images/blog/iStockmachinelearning592x333.jpg"
  },
  {
    "title":"Ayush fails in exam 🥇",
    "excerpt":"in the final exams of lcit ayush again fails by 1 mark only",
    "date": "20 March 2020",
    "image": "https://cdn0.tnwcdn.com/wp-content/blogs.dir/1/files/2016/11/shutterstock_344519003.jpg"
  },
  
];