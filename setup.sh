git clone --depth=1 https://github.com/wuyoscar/GPT-Image2-Skill.git /tmp/gpt-image2

mkdir -p toolkits/GPT-Image2-Skill

cp -R /tmp/gpt-image2/skills toolkits/GPT-Image2-Skill/
cp /tmp/gpt-image2/README.md toolkits/GPT-Image2-Skill/
cp /tmp/gpt-image2/README.zh.md toolkits/GPT-Image2-Skill/

git add .
git commit -m "Add GPT Image 2 toolkit"
git push