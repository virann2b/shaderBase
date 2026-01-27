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
    float4 g_color;
}

float4 main(PS_INPUT psInput) : SV_TARGET
{
    float2 uv = psInput.TexCoords0;
    
    uv.x ; 
    uv.y ; 
    
    //左から右にかけて白
    //return float4(uv.x, uv.x, uv.x, 1.0f);
    
    //上から下にかけて白
    //return float4(uv.y, uv.y, uv.y, 1.0f);
    
    //上から下にかけて白(1から減算することで逆になる）
    //return float4(1.0f - uv.y, 1.0f - uv.y, 1.0f - uv.y, 1.0f);
    
    //左上から右下にかけて少しずつ白
    //float4 color =  float4(uv.x + uv.y , uv.x+ uv.y,  uv.x + uv.y, 1.0f);
    //color.rgb /= 2.0f;
    //return color;
    //float x = abs(uv.x * uv.x - 0.5f);
    //float y = abs(uv.y * uv.y - 0.5f);
    
    float x = abs(uv.x - 0.5f);
    float y = abs(uv.y - 0.5f);
    
    //平方根
    //float dis = sqrt(x * x + y * y) * 2;
    float dis = (x * x + y * y) * 4;
    
    return float4(dis,dis,dis, 1.0f);


}

