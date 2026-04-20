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

<InlineSmallTitle title="第2回 システム開発の流れ（全体）" suffix="マネジメント系"
  :suffix-scale="0.58" />

<CustomTitle
  subtitle='本日のテーマ'
  :points="[
    { title: '1. ソフトウェア ライフ サイクル プロセス', desc: '(**[red]SLCP[/red]** :Software Life Cycle Process)' },
    { title: '2. IPパスポート過去問題(令和3年 問46)' },
    { title: '3. {総括|そうかつ}' }
  ]"
/>

---
routeAlias: process-page
theme: default
layout: none
class: text-center
canvasWidth: 1100
---

<script setup>
import { computed } from 'vue'

const slcpSteps = [
  {
    id: 1, title: '1.企画', color: '#B5651D',
    left: '情報システム全体の[orange]{構想|こうそう}や計画[/orange]を{策定|さくてい}するプロセスです。',
    right_sections: [
      {
        rights_title: '＜システム化構想（利用者）＞',
        rights: [
          '・経営上のニーズや課題を確認する。',
          '・業務と情報システムの[orange]将来像を明確[/orange]にした上で,[orange]全体{最適化|さいてきか}[/orange]を図る。'
        ]
      },
      {
        rights_title: '＜システム化計画（利用者：候補ﾍﾞﾝﾀﾞｰ）＞',
        rights: [
          '・システム化の基本方針を策定する。',
          '・管理体制や開発スケジュール,{概算|がいさん}コスト,[orange]{費用対効果|ひようたいこうか}[/orange]([hl]ROI[/hl] : Return on Investment)などを検討する。'
        ]
      }
    ],
    image: '/images/2_process01_1.png'
  },
  {
    id: 2, title: '2.要件定義', color: '#C19A6B', textColor: '#513820',
    left: '情報システムの[orange]機能や性能[/orange]を明確にするプロセスです。',
    right_sections: [
      {
        rights_title: '＜業務要件定義（利用者：候補ﾍﾞﾝﾀﾞｰ）＞',
        rights: [
          '日々の業務に必要な要件→業務手順,関係する[orange]組織の責任や権限[/orange]などを明確にする。'
        ]
      },
      {
        rights_title: '＜機能要件定義（利用者：候補ﾍﾞﾝﾀﾞｰ）＞',
        rights: [
          'システムに必要な機能→必要なデータ項目,処理内容,ユーザインタ要件フェースなどを明確にする。'
        ]
      },
      {
        rights_title: '＜非機能要件定義（利用者：候補ﾍﾞﾝﾀﾞｰ）＞',
        rights: [
          'システムに必要な[orange]目に見えない性能[/orange]→応答時間,稼働時間,セキュリティなどを明確にする。'
        ]
      }
    ],
    image: '/images/2_process02_1.png'
  },
  {
    id: 3, title: '3.開発', color: '#D2B48C', textColor: '#302316',
    left: '開発者が利用者の要件を取り入れながら,実際にシステムを[orange]開発[/orange]するプロセスです。',
    right_sections: [
      {
        rights_title: '＜開発工程順序（ﾍﾞﾝﾀﾞｰと利用者）＞',
        rights: [
          '[hl][orange]ソフトウェアの品質特性[/orange]（機能、使用、信頼、効率、保守、移植）[/hl]に基づき下記工程を進める',
          '1)ｼｽﾃﾑ要件定義：ｼｽﾃﾑ要件定義書の作成',
          '2)ｿﾌﾄｳｪｱ要件定義：ｿﾌﾄｳｪｱ要件定義書の作成',
          '3)ｼｽﾃﾑ設計：ｼｽﾃﾑ設計書の作成',
          '4)ｿﾌﾄｳｪｱ設計：ｿﾌﾄｳｪｱ設計書の作成',
          '5)ｿﾌﾄｳｪｱ構築：ﾌﾟﾛｸﾞﾗﾑなどの作成'
        ]
      }
    ],    
    image: '/images/2_process03_1.png'
  },
  {
    id: 4, title: '4.運用', color: '#A0845C',
    left: '利用者の検収後,日々の業務を通して新システムを稼働させ[orange]利用[/orange]するプロセスです。',
    right_sections: [
      { 
        rights_title: '＜運用の主な作業（利用者、ﾍﾞﾝﾀﾞｰ）＞', 
        rights: [
          'システムが正常に動いているか常にチェックし、トラブルを未然に防ぐ活動が中心です。',
          '1)サービスデスク（ヘルプデスク）',
          '2)システム監視：サーバー、ネットワーク、CPU使用率やﾒﾓﾘ空き容量などを確認。',
          '3)ﾊﾞｯｸｱｯﾌﾟ：定期的なデータ複製・保存。',
          '4)ﾊﾟｯﾁ適用：OSやソフトウェアの脆弱性を修正するため、最新の更新ﾌﾟﾛｸﾞﾗﾑを適用。'
        ],
      }
    ],
    image: '/images/2_process04_1.png'
  },
  {
    id: 5, title: '5.保守', color: '#7a6245',
    left: '稼働中のシステムを修正・改善し、常に[orange]最適な状態に保つ[/orange]プロセスです',
    right_sections: [
      { 
        rights_title: '＜保守の主な作業（利用者、ﾍﾞﾝﾀﾞｰ）＞', 
        rights: [
          '不具合への対応だけでなく、環境の変化に合わせたメンテナンスも含みます。',
          '1)障害保守（訂正保守も含む）',
          '2)適応保守',
          '3)改良保守（完全化保守）',
          '4)予防保守',
        ] 
      }
    ],
    image: '/images/2_process05_1.png'
  }
]

const currentStep = computed(() => Math.min($slidev.nav.clicks, slcpSteps.length - 1))
const currentSupplement = computed(() => {
  const step = slcpSteps[currentStep.value]
  if (!step?.id) return null

  return {
    pageName: `process${step.id}-hosoku-page`,
    buttonLabel: `${step.title}の補足へ`
  }
})

const getRightSections = (step) => {
  if (Array.isArray(step.right_sections) && step.right_sections.length > 0) {
    return step.right_sections
  }

  const titles = Array.isArray(step.rights_titles) && step.rights_titles.length > 0
    ? step.rights_titles
    : (step.rights_title ? [step.rights_title] : [])

  const rights = Array.isArray(step.rights) && step.rights.length > 0
    ? step.rights
    : (step.right ? [step.right] : [])

  if (titles.length <= 1) {
    return [{ rights_title: titles[0] || '', rights }]
  }

  return titles.map((title, index) => ({
    rights_title: title,
    rights: rights[index] ? [rights[index]] : []
  }))
}
</script>

<div class="page-bg">
<JinanStepFrame variant="point-bg">
  <template #header-actions>
    <button
      v-if="currentSupplement"
      class="slcp-supplement-link"
      @click="$slidev.nav.go(currentSupplement.pageName, currentStep)"
    >
      {{ currentSupplement.buttonLabel }}
    </button>
  </template>

  <JinanStep kind="title" title="ソフトウェア ライフ サイクル プロセス" />
  <JinanStep kind="title" title="** [hl][red]SLCP[/red][/hl] : [en]Software Life Cycle Process[/en]**" />

  <ProcessFlow
    :current-index="currentStep"
    :items="slcpSteps"
    :step-width="194"
    :step-height="43"
    :head-width="26"
    style="margin-top: 1rem; margin-bottom: 2rem;"
  />

  <div class="slcp-body" style="margin-top: 0.2rem;">
    <div class="slcp-panel">
      <JinanStep kind="subtitle" :title="`${slcpSteps[currentStep].title}プロセス`" />
      <JinanStep kind="body" :title="slcpSteps[currentStep].left" />
      <img :src="slcpSteps[currentStep].image" class="w-full mt-4" />
    </div>
    <div class="slcp-divider" />
    <div class="slcp-panel" style="--app-font-size-subtitle: 1.25rem; --app-font-size-body: 1.25rem;">
      <template
        v-for="(section, sectionIndex) in getRightSections(slcpSteps[currentStep])"
        :key="'right-section-' + slcpSteps[currentStep].id + '-' + sectionIndex"
      >
        <JinanStep v-if="section.rights_title" kind="subtitle" :title="section.rights_title" />
        <JinanStep
          v-for="(rightText, rightIndex) in section.rights"
          :key="'right-' + slcpSteps[currentStep].id + '-' + sectionIndex + '-' + rightIndex"
          kind="body"
          :title="rightText"
        />
      </template>
    </div>
  </div>

</JinanStepFrame>
</div>
<span v-click="4"></span>

<style>
.slcp-supplement-link {
  appearance: none;
  border: 1px solid rgba(91, 70, 48, 0.22);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.82);
  color: var(--app-title-color, #5b4630);
  padding: 0.55rem 1rem;
  font-size: 0.95rem;
  font-weight: 800;
  box-shadow: 0 10px 24px rgba(91, 70, 48, 0.12);
  backdrop-filter: blur(6px);
  transition: transform 0.18s ease, box-shadow 0.18s ease, opacity 0.18s ease;
}

.slcp-supplement-link:hover {
  transform: translateY(-1px);
  box-shadow: 0 12px 28px rgba(91, 70, 48, 0.18);
}

.slcp-supplement-link:active {
  transform: translateY(0);
}
</style>

---
theme: default
layout: none
canvasWidth: 1100
---

<div class="page-bg">
<JinanStepFrame
  variant="point-bg"
>
  <JinanStep kind="title" title="IPパスポート過去問題(令和3年 問46)" />

  <JinanStep kind="subtitle" title="システム要件定義で明確にするもののうち,性能に関する要件はどれか。" />

  <JinanStep kind="body" title="ア 業務要件を実現するシステムの機能\n" />
  <JinanStep kind="body" title="イ システムの稼働率\n" />
  <JinanStep kind="body" title="ウ 照会機能の応答時間\n" />
  <JinanStep kind="body" title="工 障害の復旧時間\n" />

  <JinanStep v-click kind="body" title="【正解】ウ\n" />
  <JinanStep v-click kind="body" title="【根拠】ア：業務要件で定義された機能は、システム要件の機能ではないため" />
  <JinanStep v-click kind="body" title="【根拠】イ：稼働率は非機能要件で定義され、システム可用性の要件であるため" />
  <JinanStep v-click kind="body" title="【根拠】ウ：正解" />
  <JinanStep v-click kind="body" title="【根拠】エ：障碍時の復旧時間は機能要件で定義され、システム可用性または信頼性であるため" />
  
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
  <JinanStep kind="title" title="SLCP講義の総括（ITマネジメントと業界の未来）" />

  <JinanStep kind="subtitle" title="1. なぜ「プロセス分け」が必要なのか？\n" />

  <JinanStep v-click kind="body" title="ITパスポートの「ストラテジ系」「マネジメント系」で学んだ通り、\nシステム開発を企画・要件定義・開発・運用と分けるのには明確な理由があります。" />
  <JinanStep v-click kind="body" title="**[green]リスクの早期発見：[/green]**\n 一気に作ると最後でミスが発覚した際の手戻りが巨大になります。フェーズごとに「承認」を挟むことで、ズレを最小限に抑えます。" />
  <JinanStep v-click kind="body" title="**[green]専門性の活用： [/green]**\n企画のプロ、設計のプロ、運用のプロがそれぞれのフェーズで責任を持つことで、品質を高めます。" />
  <JinanStep v-click kind="body" title="**[green]進捗の見える化：[/green]** \n「今、全体のどこにいるか」を明確にし、不透明なIT開発をコントロール可能にするためです。" />

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

  <JinanStep kind="subtitle" title="2. 「納期遅延」がもたらす恐ろしい連鎖" />
  
  <JinanStep v-click kind="body" title="[jp]試験でも「プロジェクトマネジメント」の重要性が説かれますが、納期が遅れることは単なる「遅刻」では済みません。[/jp]" />
  
  <JinanStep v-click kind="body" title="[jp]機会損失： 本来そのシステムで得るはずだった利益がゼロになります（例：キャンペーンに間に合わない）。[/jp]" />
  
  <JinanStep kind="body" title="[jp]コストの膨張： 開発メンバーの延べ人数（人月）が増え、プロジェクトが赤字化します。[/jp]" />

  <JinanStep v-click kind="body" title="[jp]信頼の失墜： IT業界は「信用」で成り立っています。納期遅延は企業としてのブランド価値を著しく下げ、次の契約（保守や次期開発）を失う原因になります。[/jp]" />

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
  
  <JinanStep kind="subtitle" title="3. IT業界の現状と今後の動向" />

  <JinanStep kind="body" title="[jp]これから関わるIT業界は、今まさに大きな転換期にあります。[/jp]" />
  <JinanStep v-click kind="body" title="[jp]「作る」から「使いこなす」へ：\nゼロからプログラミングする時代から、SaaS（既存サービス）やローコード・ノーコード、そして生成AIを組み合わせて迅速に価値を作る時代へ移行しています。[/jp]" />
  <JinanStep v-click kind="body" title="[jp]DX（デジタルトランスフォーメーション）の加速：\nITは単なる事務効率化のツールではなく、ビジネスモデルそのものを変える武器になりました。ITパスポートで学ぶ「経営学」と「IT技術」の掛け合わせこそが、今の現場で最も求められている視点です。[/jp]" />

  <JinanStep v-click kind="body" title="[jp]セキュリティとガバナンス：\n便利になる反面、サイバー攻撃のリスクは増大しています。技術者だけでなく、全てのビジネスパーソンに「正しく守る知識」が必須となっています。[/jp]" />

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
  <JinanStep kind="subtitle" title="4. 最後に：ITパスポートという「共通言語」" />

  <JinanStep v-click kind="body" title="[jp]この講義で学んだ用語や概念は、IT業界における**「共通言語」**です。[/jp]" />
  <JinanStep v-click kind="body" title="[jp]エンジニア、営業、経営者が同じ言葉で会話できて初めて、プロジェクトは成功します。試験合格をゴールにするのではなく、この知識を「現場で対話するための武器」として使いこなしていってください。[/jp]" />

</JinanStepFrame>
</div>

---
routeAlias: process1-hosoku-page
class: supplement-page
---

# 補足（企画）

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 0)">
  back
</button>

---
routeAlias: process2-hosoku-page
class: supplement-page
---

# 補足（要件定義）

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 1)">
  back
</button>

---
routeAlias: process3-hosoku-page
class: supplement-page
---

# 補足（開発）

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 2)">
  back
</button>

---
routeAlias: process4-hosoku-page
class: supplement-page
---

# 補足（運用）

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 3)">
  back
</button>

---
routeAlias: process5-hosoku-page
class: supplement-page
---

# 補足　保守の主な作業（利用者、ﾍﾞﾝﾀﾞｰ）（保守）

  <JinanStep kind="subtitle" title="1)障害保守（訂正保守も含む）" />
  <JinanStep kind="body" title="ｼｽﾃﾑにﾊﾞｸﾞ（不具合）が見つかった際に、ﾌﾟﾛｸﾞﾗﾑを修正して正常な状態に戻します。" />

  <JinanStep kind="subtitle" title="2)適応保守" />
  <JinanStep kind="body" title="OSのｱｯﾌﾟﾃﾞｰﾄや法改正（消費税率の変更など）に合わせて、ｼｽﾃﾑを書き換えます。" />

  <JinanStep kind="subtitle" title="3)改良保守（完全化保守）" />
  <JinanStep kind="body" title="「もっと処理を速くしたい」「操作画面を使いやすくしたい」といった要望に応えて機能を強化します。" />

  <JinanStep kind="subtitle" title="4)予防保守" />
  <JinanStep kind="body" title="将来障害が起きそうな箇所を、トラブルが発生する前にあらかじめ修正します。" />

<button class="supplement-back-button" @click="$slidev.nav.go('process-page', 4)">
  back
</button>


