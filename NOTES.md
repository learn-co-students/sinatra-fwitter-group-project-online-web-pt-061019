This was originally in tweets/new: 

<% if Helpers.is_logged_in?(session) %>
<%= @error %>

  <% else %>
      <h1> You Must Be Logged in to Make Tweets </h1>
  <% end %>