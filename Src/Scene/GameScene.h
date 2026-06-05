#pragma once
#include <memory>
#include <DxLib.h>
#include "SceneBase.h"
class Stage;
class SkyDome;
class Player;
class Shader;

class GameScene : public SceneBase
{

public:

	// コンストラクタ
	GameScene(void);

	// デストラクタ
	~GameScene(void);

	void Init(void) override;
	void Update(void) override;
	void Draw(void) override;

private:

	// ステージ
	std::unique_ptr<Stage> stage_;

	// スカイドーム
	std::unique_ptr<SkyDome> skyDome_;

	// プレイヤー
	std::unique_ptr<Player> player_;

	// シェーダ
	std::unique_ptr<Shader> shader_;
};
