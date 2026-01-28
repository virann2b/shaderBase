// ピクセルシェーダーの入力
struct PS_INPUT
{
    float4 Position : SV_POSITION; // 座標( プロジェクション空間 )
    float4 Diffuse : COLOR0; // ディフューズカラー
    float2 TexCoords0 : TEXCOORD0; // テクスチャ座標
};
// 定数バッファ：スロット0番目(b0と書く)
cbuffer cbParam : register(b0)
{
    float g_time;
    float g_speed;
    float4 g_color;
    
}

// 描画するテクスチャ
Texture2D g_SrcTexture : register(t0);//炎
Texture2D g_NoizeTexture : register(t1);//ノイズ


// サンプラー：適切な色を決める処理
SamplerState g_SrcSampler : register(s0);


float4 main(PS_INPUT psInput) : SV_TARGET
{
    
    // uvスクロール
    float2 uv = psInput.TexCoords0;
    
    //ノイズ用UV
    float2 noize_uv = uv;
    
    //縦の動き(上に動く）
    noize_uv.y += frac(g_time * 0.5f);
    
    //横の動き(往復の動き） sin(動く速さ）*　動く幅の大きさ（あってもなくてもよい）
    noize_uv.x += sin(g_time * 0.4f)* 0.3;
   

    // 変更されたuv座標を元に色を取得する
    float4 noize = g_NoizeTexture.Sample(g_SrcSampler, noize_uv);
   //RGBA
    
    
    //火の画像で使用するUVの調整
    float2 fire_uv = uv;
    
    fire_uv.y += noize.r * 0.2f;
    
    float4 srcCol = g_SrcTexture.Sample(g_SrcSampler, fire_uv);
    
    if(srcCol.a < 0.01f)
    {
        //描画しない
        discard;
    }
    return srcCol;
    
    
}

