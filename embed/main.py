import looker_sdk
import os
import pydantic
import json
from google.cloud import bigquery
from pydantic import ValidationError
from collections import namedtuple

PROJECT_ID = os.environ.get("PROJECT_ID", "XXXXX")
DATASET_NAME = os.environ.get("DATASET_NAME", "XXXXX")
TABLE_NAME = os.environ.get("TABLE_NAME", "XXXXX")

# required for looker sdk
os.environ['LOOKERSDK_BASE_URL'] = "XXXXX"
os.environ['LOOKERSDK_CLIENT_ID'] = "XXXXX"
os.environ['LOOKERSDK_CLIENT_SECRET'] = "XXXXX"
os.environ['LOOKERSDK_VERIFY_SSL'] = "true"

bq_client = bigquery.Client(PROJECT_ID)
looker_client = looker_sdk.init40()

class GetUrlsRequest(pydantic.BaseModel):
    """
    Request body for get_urls endpoint
    """
    user_id: str


def create_get_url_looker_request_params(dashboard_url: str,
                                         user_id: str,
                                         group_ids: str,
                                         security_value: str,
                                         session_length=7200) -> looker_sdk.models.EmbedSsoParams:
    """
    Get looker embed params object
    Args:
        dashboard_url:
        user_id:
        group_ids:
        security_value:
        session_length:

    Returns:
        looker_sdk.models.EmbedSsoParams
    """
    group_ids = f"[{group_ids}]" if isinstance(group_ids, int) else group_ids
    embed_params = looker_sdk.models.EmbedSsoParams(
        target_url=dashboard_url,
        session_length=session_length,
        force_logout_login=True,
        external_user_id=user_id,
        group_ids=json.loads(group_ids),
        user_attributes={
            "security_value": security_value
        }
    )

    return embed_params


def get_looker_embed_url(params: looker_sdk.models.EmbedSsoParams) -> str:
    """
    Call to the SDK and return a URL string
    Args:
        params:
    Returns:
        embed url
    """
    url = looker_client.create_sso_embed_url(body=params)
    return url.url


def get_looker_title_from_url(url: str) -> str:
    """
    Lookup title from base looker url
    Args:
        url:

    Returns:
        title
    """
    dashboard_number = url.split('/')[-1]
    dashboard = looker_client.dashboard(dashboard_number)
    return dashboard.title


def get_all_urls(request):
    """
    Args:
        request:

    Returns:
        dictionary of looker embed urls and titles
    """
    args = request.args
    print(f'received the following request params: {args}')
    try:
        url_request: GetUrlsRequest = GetUrlsRequest(**args)
    except ValidationError as e:
        print(e)
        return "incorrect parameters for api request, please provide user_id only", 400

    query = f"""
            SELECT
                security_value,
                user_looker_group,
                looker_base_urls,
            FROM `{PROJECT_ID}.{DATASET_NAME}.{TABLE_NAME}`
            WHERE security_value = @security_value;
            """
    job_config = bigquery.QueryJobConfig(
        query_parameters=[
            bigquery.ScalarQueryParameter("security_value", "STRING", url_request.user_id)
        ]
    )

    df_users = bq_client.query(query, job_config=job_config).to_dataframe()

    if df_users.empty:
        return "user_id not found", 404

    # expect only one row to be returned so use zero index
    user = df_users.to_dict(orient='index')[0]
    dashboard_urls = user['looker_base_urls']
    embed_urls = {}
    for url in dashboard_urls:
        looker_request_params = create_get_url_looker_request_params(url,
                                                                     user['security_value'],
                                                                     user['user_looker_group'],
                                                                     user['security_value'])

        try:
            title = get_looker_title_from_url(url)
            embed_urls[title] = get_looker_embed_url(looker_request_params)
        except Exception as e:
            print(e)
            return "issue with creating looker url, please check user_id is valid", 400, {'Content-Type': 'application/json'}

    return json.dumps(embed_urls), 200, {'Content-Type': 'application/json'}


if __name__ == '__main__':
    # example for one user
    Request = namedtuple("Request", "args")

    get_urls_request = Request(args={'user_id': 'user_id_abc'})
    print(get_all_urls(get_urls_request))
