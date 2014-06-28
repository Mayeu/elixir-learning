defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn = conn.fetch([:cookies, :params])
    conn = conn.assign(:title, "Welcome to Dwitter!")
  end

  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  post "/post" do
    conn = conn.assign(:content, conn.params[:content])
    render conn, "post.html"
  end

  get "/" do
    render conn, "index.html"
  end
end
