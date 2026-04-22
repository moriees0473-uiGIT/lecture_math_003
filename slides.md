---
theme: seriph
drawers: false
navbars: false
presenter: false
toc: false
background: none
class: text-center
transition: slide-left
comark: true
duration: 35min
canvasWidth: 1100
---

<InlineSmallTitle title="二次方程式② ： 因数分解 " suffix="第3回 基礎数学Ⅱ"  :suffix-scale="0.58" />

<CustomTitle
  subtitle='本日のテーマ'
  :points="[
    { title: '1. 前回の復習　 ： 二次方程式①（意味と基本）' },
    { title: '2. 二次方程式②　： 因数分解（いんすう ぶんかい）' },
    { title: '3. 小テスト' }
  ]"
/>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="title" title="1. 前回の復習 ： 二次方程式①（意味と基本）" />
  <JinanStep kind="subtitle" title="Q1．次の方程式の[red]解[/red]を[red]すべて表している[/red]ものを\n　 　[red]1つ選びなさい[/red]。" />

  <JinanStep kind="title" title="[math]x^2 = 25[/math]\n" style="margin-left: 10em;" />
  <JinanStep kind="subtitle" title="[gray]ア[/gray]　[math]0[/math]　　　[gray]イ[/gray]　[math]5[/math]　　　[gray]ウ[/gray]　[math]-5[/math]　　　[gray]工[/gray]　[math]±5[/math]\n\n" style="margin-left: 5em;"/>  

  <JinanStep v-click kind="body" title="【正解】エ\n　　[math]±5[/math]は、２つの解を含んでいるので正解です。" />


</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="subtitle" title="Q2．次の方程式の[red]解[/red]を[red]すべて表している[/red]ものを\n　 　[red]1つ選びなさい[/red]。\n" />

  <JinanStep kind="title" title="[math]x^2 = 0[/math]\n" style="margin-left: 10em;" />

  <JinanStep kind="subtitle" title="[gray]ア[/gray]　[math]0[/math]　　　[gray]イ[/gray]　[math]0^0[/math]　　　[gray]ウ[/gray]　[math]0^2[/math]　　　[gray]工[/gray]　[math]±0[/math]\n\n" style="margin-left: 5em;"/>

  <JinanStep v-click kind="body" title="【正解】ア\n注）イの[red][math]0^0[/math][/red]は、数学的には[red]{不定|ふてい}[/red]であり、出題されるのは{稀|まれ}です。\n\nウとエは、以下のように[green]まとめる必要[/green]があるため、不正解です。\n　　　[math]0^2=0[/math]であり、[math]±0=0[/math]であるため、解は[red]０[/red]の１つです。" />
 
</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <!--
  <JinanStep kind="title" title="1. 前回の復習 ： 二次方程式①（意味と基本）" />
  -->
  <JinanStep kind="subtitle" title="Q3．次の方程式の[red]解[/red]を[red]すべて表している[/red]ものを\n　 　[red]1つ選びなさい[/red]。\n" />

  <JinanStep kind="title" title="[math]x^2 = -1[/math]\n" style="margin-left: 10em;"  />

  <JinanStep kind="subtitle" title="[gray]ア[/gray]　[math]-1[/math]　　[gray]イ[/gray]　[math]1[/math] [gray]　　ウ[/gray]　[math]-1^2[/math]　　[gray]工[/gray]　[math]解なし[/math]\n\n" style="margin-left: 5em;"/>

  <JinanStep v-click kind="body" title="【正解】エ　\n　　[gray]注）[green]{虚数|きょすう}:[math]±i[/math] の選択肢がないため[/green]、実数として\n　　　　「解なし」が正解となります。[/gray]" />
 
</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="title" title="1. 前回の復習 ： 二次方程式①（意味と基本）" />
  <JinanStep kind="subtitle" title="◆ まとめ（[math]x^2 のx[/math] の解は、以下の３パターン）\n" />

  <JinanStep v-click kind="body" title="[green]Ａパターン（解が２つ）[/green]\n　[math]x^2 = 9 = ±sqrt(9) = ±sqrt(3^2)　 {∴|ゆえに} x = ±3[/math]" style="margin-left: 3em;"/>

  <JinanStep v-click kind="body" title="[green]Ｂパターン（解が１つ）[/green]\n　[math]x^2 = 0 = ±sqrt(0) = ±sqrt(0^2) 　{∴|ゆえに}X = 0[/math]" style="margin-left: 3em;"/>

<JinanStep v-click kind="body" title="[green]Ｃパターン（解なし）[/green]\n　[math]x^2 = -1 = ±sqrt(-1)[/math]　　　　　　{∴|ゆえに} 解なし\n　 [gray]注）数学的には、[green]{虚数|きょすう} [math]i^2 = -1[/math][/green] として表せます。\n　　　 虚数とは、実数ではない[green]「想像上の数」[/green]です。[/gray]" style="margin-left: 3em;"/>

</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="title" title="2. 因数分解" />
  <JinanStep kind="body" title="１）{展開|てんかい} ⇄ {因数分解|いんすう ぶんかい}（{公式|こうしき}）\n" />

  <div style="display: flex; justify-content: flex-start; align-items: flex-start; height: 20.5vh;margin-top: -10px;">
    <img src="/images/Factorization_01.png" alt="因数分解と展開" style="height: 80%; width: 80%; object-fit: contain; display: block; margin-left: 40px; " />
  </div>

  <div v-click style="display: flex; justify-content: flex-start; align-items: flex-start; height: 25vh; margin-top: -22px;">
    <img src="/images/Factorization_02.png" alt="因数分解と展開" style="height: 80%; width: 80%; object-fit: contain; display: block; margin-left: 40px;" />
  </div>

  <div v-click style="display: flex; justify-content: flex-start; align-items: flex-start; height: 23.5vh; margin-top: -27px;">
    <img src="/images/Factorization_03.png" alt="因数分解と展開" style="height: 80%; width: 80%; object-fit: contain; display: block; margin-left: 40px;" />
  </div>

</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="body" title="２）基本の{公式展開|こうしき てんかい} \n" />

  <JinanStep kind="body" title="① {共通因数|きょうつう いんすう}でくくる \n" />
  <JinanStep kind="body" title="[math]ax + bx = (a + b)x[/math]\n" style="margin-left: 5em;" />

  <JinanStep kind="body" title="② たすき{掛|か}け{型|がた}\n" />
  <JinanStep kind="body" title="[math]x^2 + (a + b)x +ab = (x + a)(x + b)[/math]\n" style="margin-left: 5em;" />

  <JinanStep kind="body" title="③ {平方|へいほう}の{差|さ}\n" />
  <JinanStep kind="body" title="[math]a^2 - b^2 = (a - b)^2[/math]\n" style="margin-left: 5em;" />

</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="body" title="④ {完全平方|かんぜん へいほう}（2{乗|じょう}の{形|かた}) \n" />
  <JinanStep kind="body" title="[math]a^2 + 2ab + b^2 = (a + b)^2[/math]\n" style="margin-left: 5em;" />

  <JinanStep kind="body" title="⑤ 2次式の{一般形|いっぱんがた}（{発展|はってん}）\n" />
  <JinanStep kind="body" title="[math]ax^2 + bx +c = (x - α)(x - β)[/math]\n" style="margin-left: 5em;" />
  <JinanStep kind="body" title="注）[math] α, βは解である[/math]\n" style="margin-left: 5em;" />

  <JinanStep kind="body" title="３）０の{法則|ほうそく} \n" />
  <JinanStep kind="body" title="[math](x - α)(x - β) = 0 {∴|ゆえに} X = α, β[/math]\n" style="margin-left: 5em;" />
</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <!--
  <JinanStep kind="title" title="3. 小テスト" />
  -->
  <JinanStep kind="subtitle" title="次の[math]x^2 のx[/math] の解を答えなさい。\n" />

  <JinanStep kind="body" title="Q1. [math]x^2 + 3x = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math]x(X + 3) = 0 {∴|ゆえに} X = 0, -3[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q2. [math]x^2 - 5x = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math]x(X - 5) = 0 {∴|ゆえに} X = 0, 5[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q3. [math]x^2 + 4x = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math]x(X + 4) = 0 {∴|ゆえに} X = 0, -4[/math]"" style="margin-left: 6em;"/>
  
</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="body" title="Q4. [math]x^2 - 9 = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math](x + 3)(X - 3) = 0 {∴|ゆえに} X = ±3[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q5. [math]x^2 - 1 = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math](x + 1)(X - 1) = 0 {∴|ゆえに} x = ±1[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q6. [math]x^2 + 6x = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math] x(X + 6) = 0 {∴|ゆえに} X = 0, -6[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q7. [math]x^2 - 4x = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math] x(X - 4) = 0 {∴|ゆえに} X = 0, 4[/math]"" style="margin-left: 6em;"/>

</JinanStepFrame>
</div>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="body" title="Q8. [math]x(x + 2) = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math] {∴|ゆえに} X = 0, -2[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q9. [math](x -3)(x + 1) = 0[/math]" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 [math] {∴|ゆえに} x = 3, -1[/math]"" style="margin-left: 6em;"/>

  <JinanStep kind="body" title="Q10.因数分解で解く理由は？" style="margin-left: 3em;"/>
  <JinanStep v-click kind="body" title="【正解】 0の法則を使うため\n　　　（掛けて 0 になるなら、どれかひとつは絶対に 0）" style="margin-left: 6em;"/>
  
</JinanStepFrame>
</div>

---
routeAlias: process1-hosoku-page
class: supplement-page
---

# 補足

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 0)">
  back
</button>



