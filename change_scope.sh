#!/bin/bash
#author flyjay
# 指定タグの公開範囲を一括変更
# 使用前提
# Docbaseのトークン設定
# 対象記事のIDを洗い出す
# 公開範囲のグループIDを確認
# 予め jq をインストールしてください。
TOKEN="*********************************"
BASE_URL="https://api.docbase.io/teams/【your_team_name】/posts/"
POST_IDS='
111
333
'
## 変更後IDを指定
CHANGE_TO_GID="****"
for id in $POST_IDS
do
    is_target=`curl -s -H "X-DocBaseToken: ${TOKEN}" ${BASE_URL}/${id} | jq .tags[] | grep "target_tag" | wc -l`
    if [ $is_target != 0 ]; then
       echo "ID${id}の記事は変更対象ですので、公開範囲を「〇〇」に変更します。"
       curl -s -H "X-DocBaseToken: ${TOKEN}" -H 'Content-Type: application/json' -X PATCH   -d '{"scope": "group", "groups": '${CHANGE_TO_GID}'}' ${BASE_URL}/${id}
    else
       echo "ID${id}のは変更対象ではないようで、ご確認ください。"
    fi
done

