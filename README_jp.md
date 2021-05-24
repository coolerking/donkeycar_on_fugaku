# 富岳上でdonkeycarパッケージをインストールするためのスクリプト

富岳上のログインノードからdonkeycarパッケージをインストールするための`pjsub`でサブミットするためのセットアップスクリプトを提供します。

## 事前準備

* 富岳ログインノードへログインする
* 計算ノードへログインする

```bash
pjsub --interact -L "node=1" -L "elapse=6:00:00" --sparam "wait-time=3600"
```

* 環境変数を設定する

```bash
export PATH=/home/apps/oss/PyTorch-1.7.0/bin:$PATH
export LD_LIBRARY_PATH=/lib64:/home/apps/oss/PyTorch-1.7.0/lib:$LD_LIBRARY_PATH
```

* Spack をインストールする

```bash
git clone https://github.com/spack/spack ~/spack
cd ~/spack
git checkout releases/v0.16
```

* Python virtualenv パッケージをインストールする

```bash
pip install virtualenv --user
```

* virtualenv 環境 `ratf_pytorch170` を作成する

```bash
mkdir -p ~/local/aarck64/virtualenv
cd ~/local/aarck64/virtualenv
python3 -m virtualenv -p python3 ratf_pytorch170 --system-site-packages
```

* Spack 環境 `ratf_pytorch170` を作成する

```bash
source ~/spack/share/spack/setup-env.sh
spack env create ratf_pytorch170
spack env activate ratf_pytorch170
```

* 計算ノードからログアウトする

```bash
exit
```

## 事前パッケージのインストール

* 富岳ログインノードへログインする
* このリポジトリのスクリプトを展開する

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/autorope/donkeycar.git
cd donkeycar
git checkout master
cd ..
git clone https://github.com/coolerking/donkeycar_on_fugaku
cd donkeycar_on_fugaku
git checkout master
cd setup
chmod +x *.sh
```

* 以下のスクリプトをつかって富岳通常ジョブを`pjsub`実行する。

```bash
pjsub 11mesa.sh
pjsub 12hdf5.sh
pjsub 13openblas.sh
pjsub 14libtiff.sh
pjsub 15openjpeg.sh
pjsub 16atlas.sh
```

> `watch pjstat` を実行すると、2秒毎に更新されるジョブ実行状況を確認できます。
> `pjdel <JOB_ID>` を実行すると、該当IDのジョブを削除することができます。

## ライセンス

本リポジトリのコードはすべて [MITライセンス](./LICENSE) 準拠とします。
