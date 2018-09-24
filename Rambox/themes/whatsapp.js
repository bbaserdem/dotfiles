function applycss(css) {
    var head = document.getElementsByTagName('head')[0];
    var s = document.createElement('style');
    s.setAttribute('type', 'text/css');
    s.appendChild(document.createTextNode(css));
    head.appendChild(s);
}

applycss(`
    /*================================
	Whatsapp Dark Theme - OrriGo
	by OrriGo
	https://userstyles.org/styles/137247
	Last updated: v17: 15/04/2018
	- update style

NOTE: 
Feel free to leave any comments below and to donate.
Please donate to support my work. Even just a little donation make my day and boost my confidence.
================================*/


/* Chat lines */

  webkit-scrollbar-thumb
  {
    background-color: #2c2c2c!important;
  }
/* On event. */

  #side ._1NrpZ ._2EXPL._1f1zm,
#side ._1NrpZ ._2EXPL:hover
  {
    background-color: rgba(0, 204, 187, 0.24) !important;
  }
/*header*/

  .chat-body,
.body,
.header-body
  {
    border-top: 1px solid #f2f2f20 !important;
    padding-right: 15px;
  }

  .chat-status
  {
    color: #898989 !important;
	/* Chat Text */;
  }

  html[dir=ltr] .Tkt2p
  {
    padding: 6px 7px 8px 9px;
    background-color: rgba(107, 107, 107, 0.39);
    border-radius: 7.5px;
  }

  html[dir] ._2xOyO
  {
    background-color: rgba(0, 0, 0, 0.86);
  }
/* Chat Send Files */

  html[dir] ._2CORf ._12xX7
  {
    background-color: #d1ecbc;
    background-color: rgba(107, 107, 107, 0.39);
  }
/*bottom chat*/

  .pane-footer.pane-chat-footer
  {
    color: darkturquoise !important;
    background: rgba(255, 255, 255, 0.3) !important;
  }

  .input-container
  {
    background: rgba(255, 255, 255, 0.2) !important;
    border: none !important;
  }

  ._2dGjP
  {
    box-sizing: border-box;
    color: #d8d8d8 !important;
  }
/*Datum chat menu */

  .message-system
  {
    background-color: rgba(0, 241, 255, 0.39);
    padding: 5px 12px 6px 12px;
    border-radius: 7.5px;
  }
/*chat Share */

  ._2DNgV._1i1U7,
.jZ4tp._1i1U7
  {
    background: transparent!important;
  }
/* Chat text color. */

  .message-in,
.message-out,
.message
  {
    background-color: #2c2c2c!important;
  }

  .message-in .selectable-text,
.message-out .selectable-text,
.message .quoted-mention
  {
    color: #dddddd !important
	/* Unread OK and Hover Icons */;
  }

  [role="button"]:hover span svg path,
[data-icon]:hover svg path,
button:hover span svg path,
[data-icon="status-dblcheck-ack"] svg path,
._1DZAH[role="button"] [data-icon="msg-dblcheck-ack"] svg path
  {
    fill: #31f94f !important;
  }

  button span svg path,
button,
[role="button"] span svg path,
._10anr:hover button span svg g path[fill]
  {
    fill: rgba(27, 177, 170, 0.2) !important;
    fill-opacity: 1 !important;
    opacity: 1 !important;
  }

  ._10anr.vidHz._14ou2._28zBA,
html[dir] .iHLo1,
html[dir] ._3hV1n,
html[dir] ._3v_lq.j5Hcb,
html[dir] ._1UvQg
  {
    background-color: #999!important;
  }
/*bottom chat menu */

  html[dir] .gQzdc._3sdhb
  {
    background: #CACACA !important;
  }

  .drawer-header-small
  {
    background-color: darkcyan !important;
  }

  .html[dir] ._1AKfk
  {
    background-color: #2c2c2c !important;
  }

  html[dir] ._1CRb5 ._1AKfk
  {
    background-color: transparent !important;
    color: deepskyblue;
  }

  html[dir] ._1AKfk
  {
    background-color: transparent;
  }

  html[dir] .jN-F5
  {
    background: content-box !important;
    color: #00ff7f;
  }

  .block-compose
  {
    background: #00635a !important;
  }

  .html[dir] ._1CkkN
  {
    background-color: darkcyan !important;
  }

  .drawer-header
  {
    background-color: #2c2c2c;
  }

  .gQzdc
  {
    background-color: #2c2c2c !important;
  }

  .html[dir] .gQzdc
  {
    background-color: #2c2c2c !important;
  }

  .section-header
  {
    background-color: #242424 !important;
  }
/*line bottom write zone "new group"*/

  .input-advanced.active
  {
    border-bottom: 1px solid #ccc!important;
  }
/*new group message*/

  .placeholder
  {
    color: #1f1f1f!important;
  }
/*estado*/

  .input-advanced .input-line,
.input-line input
  {
    color: #CACACA!important;
  }
/*menu */

  html[dir] ._3_R6X,
.message-in,
.message-out,
html[dir] ._2uLFU,
progress,
#side,
footer,
._2uLFU._3aCko.Qap-N,
html[dir] ._3D9Wd,
.WX_XW,
._2Par4,
html[dir] ._3gUiM,
html[dir] ._1CnF3,
html[dir] ._1sGGp._2nFG1,
html[dir] .Uukb4,
option,
html[dir] ._2NbD3,
html[dir] ._2EYZY,
html[dir="ltr"]
  {
    background-color: rgba(0, 0, 0, 0.20)!important;
  }

  ._1fkhx
  {
    background-color: #565555 !important;
  }

  html,
body,
div,
applet,
object,
iframe,
h1,
h2,
h3,
h4,
h5,
h6,
p,
blockquote,
pre,
a,
abbr,
acronym,
address,
big,
cite,
code,
del,
dfn,
em,
img,
ins,
kbd,
q,
s,
samp,
small,
strike,
strong,
sub,
sup,
tt,
var,
b,
u,
i,
center,
dl,
dt,
dd,
ol,
ul,
li,
fieldset,
form,
label,
legend,
table,
caption,
tbody,
tfoot,
thead,
tr,
th,
td,
article,
aside,
canvas,
details,
embed,
figure,
figcaption,
footer,
header,
hgroup,
menu,
nav,
output,
ruby,
section,
summary,
time,
mark,
audio,
video,
select,
option,
textarea
  {
    font-family: Roboto, sans-serif!important;
    color: #00f1ff;
  }

  ._25Ooe .label
  {
    color: #00f9e4;
  }
/*Titel Chat */

  .O90ur
  {
    color: #00fdffb5;
    font-style: italic;
  }

  ._111ze
  {
    font-weight: 500;
  }

  ._2zCDG
  {
    font-weight: normal;
    overflow: hidden;
    color: #8efffb;
  }

  ._25Ooe
  {
    color: #20abff;
  }

  ._3BCzw
  {
    background-color: cadetblue;
  }

  .DYGf2,
._3EFt_,
._3cMIj
  {
    color: rgba(0, 253, 255, 0.97);
  }

  .CxUIE ._25Ooe
  {
    font-weight: 500;
    color: #09d261;
  }

  ._3T2VG
  {
    text-transform: capitalize;
    color: deepskyblue;
  }
/*Emoji Icons */

  html[dir=ltr] .Gz6Af
  {
    font-family: Roboto, sans-serif!important;
    color: #00f1ff;
  }

  html[dir=ltr] ._28nB8
  {
    background-color: #2C2C2C !important;
  }

  html[dir=ltr] .QQnvT
  {
    background-color: #2C2C2C !important;
  }

  html[dir=ltr] ._2Brv4
  {
    background-color: #2C2C2C !important;
  }

  html[dir] ._16pld
  {
    background-color: #2C2C2C !important;
  }

  #startup,
#initial_startup,
.app-wrapper::after,
html[dir] ._3dqpi,
html[dir] ._3auIg,
html[dir] ._3CPl4,
html[dir] ._2MSJr,
html[dir] ._1NrpZ,
html[dir] ._2EXPL,
html[dir] .gQzdc::after,
html[dir] ._3qlW9,
html[dir] ._1GX8_,
html[dir] ._3AwwN,
html[dir] ._1WliW,
html[dir] ._3AwwN::after,
html[dir] ._3dGYA,
html[dir] ._3oju3,
html[dir] ._2bXVy,
html[dir] ._1CSx9,
html[dir] ._1CRb5,
html[dir] ._1CkkN,
html[dir] ._2fq0t,
html[dir] ._1XwnX,
input,
header,
html[dir] ._39pS-,
html[dir] ._1iMEz,
html[dir] .OMzAb,
._1VD7W,
html[dir] ._3b2Cf,
html[dir] .MS-DH::before,
html[dir] .MS-DH._2-mCk,
html[dir] ._2lwig._2nFG1,
html[dir] .MS-DH._2-mCk:before,
html[dir] .MS-DH._2-mCk:after,
html[dir] .IKxkY ._12xX7,
html[dir] .gQzdc:after,
html[dir] ._1GX8_,
html[dir] .ZwkQK,
html[dir] ._2U_Zc::before
  {
    background-color: #2c2c2c;
  }

  html[dir] .gQzdc._3sdhb ._2MSJr
  {
    background-color: #2c2c2c;
  }

  html[dir] ._1qdni,
html[dir] .R0lQ6,
html[dir] .mnt6B,
html[dir] .bZ3B9,
html[dir] ._3ETD3
  {
    background-color: transparent!important;
    color: #00ffa3;
  }

  .dropdown-item-action
  {
    color: #000000;
  }

  [title*="audio"].emojitext.ellipsify
  {
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-duration: 1s;
    -webkit-animation-name: escv;
  }

  [data-asset-intro-image]
  {
    background-image: url("http://i.imgur.com/R4LmRLD.png");
    position: relative;
    background-color: #2c2c2c;
    left: 40px;
    top: 30px;
  }

  .message-in .tail-container,
.message-out .tail-container
  {
    background: none
	/* full screen */;
  }

  .app-wrapper-web .app
  {
    border-radius: 4px !important;
    top: 0px !important;
    width: 100% !important;
    height: 100% !important;
    margin: 0 auto !important;
  }
	/* Update */

  ._24k3z, ._2U5s1, ._2rR_l
  {
    background-color: #2c2c2c !important;
    color: #00ffa3 !important;
  }

  ._2ByZq
  {
    background-color: #2c2c2c !important;
    color: #21524e29 !important;
  }
`);
