<?php

$envPath = getenv('GITHUB_EVENT_PATH');

if (empty($envPath) || file_exists($envPath)) {
    echo "GITHUB_EVENT_PATHが取得できてません" . PHP_EOL;
}

$envJson = file_get_contents($envPath);

$envData = json_decode($envJson, true);


if (!$envData) {
    echo "データが取得できませんでした" . PHP_EOL;
}
//PRの情報を取得
$PRurl = $envData['pull_request']['url'];
$PRnum = $envData['number'];

echo "PRのurl:" . $PRurl . PHP_EOL;
echo "PRの番号:" . $PRnum . PHP_EOL;


//APIの認証情報
$apiKey = getenv('CLAUDE_API_KEY');

if (empty($apiKey)) {
    echo "APIのキーがありません" . PHP_EOL;
}

//ヘッダー情報
$header = [

    "x-api-key:" . $apiKey,
    "anthropic-version: 2023-06-01",
    "content-type: application/json"
];


//ボディ情報
$body = [

    "model" => "claude-3-7-sonnet-20250219",
    "max_tokens" => 1024,
    "messages" => [
        [
            "role" => "user",
            "content" => "このプルリクエストのソースコードを日本語に要約してください"
        ]
    ]
];




$ch = curl_init('https://api.anthropic.com/v1/messages'); 
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($body));

$response = curl_exec($ch);
$httpStatus = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError = curl_error($ch);


curl_close($ch);

if(!$response){
    echo "レスポンスが空でした" . PHP_EOL;
}

if(!in_array($httpStatus, [200, 201, 202])){
    echo "ステータスコード" .$httpStatus . PHP_EOL;
}
if($curlError){
    echo "エラーです" .$curlError  . PHP_EOL;
}

$responseData = json_decode($response, true); 
print_r($responseData);


