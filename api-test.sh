# brew install httpie
# start with an empty database
# rails s &

http POST :3000/todos title=Mozart created_by=1
http :3000/todos
http POST :3000/todos title=Mozart created_by=1
http :3000/todos
http PUT :3000/todos/1 title=Beethoven
http DELETE :3000/todos/1
http :3000/todos

