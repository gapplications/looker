# Embedding Looker
main.py script is to be used for generating one-time Looker link(s) to be embedded into iframes in applications.

Python script to be hosted and made callable by application where content is wanting to be embedded; through cloud function or similar method.

Application needs to push through unique ID for the user wanting to view content. That user_id then needs to be cross referenced against a Bigquery table which says what dashboards to show that user. Example schema:
| security_value | looker_group_id | looker_dashboard_urls                                |
|----------------|-----------------|------------------------------------------------------|
| user_id_123    | 1               | ["looker.com/dashboard/1", "looker.com/dashboard/2"] |
| user_id_124    | 1               | ["looker.com/dashboard/1", "looker.com/dashboard/2"] |
| user_id_abc    | 2               | ["looker.com/dashboard/3"]                           |


The looker_group_id is group_id that these users should go into in Looker. A user attribute ("user_type") value can be set against those users, e.g:
| group_id | group_name            | user_type_value    |
|----------|-----------------------|--------------------|
| 1        | embed_customers       | customers          |
| 2        | embed_customer_groups | customer_groups    |

Then in your Looker explores you can filter the results to just the relevant user:
```
{% if _user_attributes['user_type'] == "admin" %}
    1=1
{% elsif _user_attributes['user_type'] == "customer" %}
    ${customer_id} = "{{ _user_attributes['security_value'] }}"
{% elsif _user_attributes['user_type'] == "customer_group" %}
    ${customer_group_id} =  "{{ _user_attributes['security_value'] }}"
{% else %}
    1=0
{% endif %}
```

When the link is being generated it will create a new Looker Embed user if the user_id has not had a link generated before.
The link will only be valid on a one-time use. If the user refreshes their page or goes back then new links will need to be generated.


Script returns json, e.g:
('{"Dashboard title": "https://looker.com/login/embed/XXXXXXXXXXX"}', 200, {'Content-Type': 'application/json'})