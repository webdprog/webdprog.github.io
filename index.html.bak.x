<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#8b6340">
<link rel="manifest" href="#" id="manifest-link">
<title>Labdeck</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;700;800&family=DM+Mono:wght@300;400&family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&family=Noto+Serif+SC:wght@400;700&family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,700;12..96,800&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
<style>
*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent}
:root{
  --bg:#faf7f2;--surface:#f2ece0;--surface2:#ebe3d5;
  --border:rgba(140,110,70,0.13);--text:#2a1f0f;--muted:#a8947a;
  --accent:#8b6340;--accent-bg:rgba(139,99,64,0.09);
  --accent-light:#d4a96a;--danger:#c0392b;
  --ink:#2a1f0f;--paper:#faf7f2;--paper2:#f2ece0;
  --vermillion:#c0392b;--gold:#d4a96a;--gold-light:#f0d080;
  --jade:#2e8b57;--sky:#3a6ea5;--cl-muted:#a8947a;
  --card-bg:#ffffff;--shadow:0 4px 24px rgba(42,31,15,0.10);
  --radius:18px;--transition:0.3s cubic-bezier(.4,0,.2,1);
  --hf-bg:#080c0e;--hf-bg2:#0f1518;--hf-bg3:#161c20;
  --hf-ln:#232d33;--hf-ln2:#2e3a40;
  --hf-tx:#dde8ec;--hf-tx2:#7a9099;--hf-tx3:#3d5560;
  --hf-lime:#7fff6a;--hf-lime2:#a8ff96;
  --hf-amber:#ffb347;--hf-sky:#4db8ff;--hf-rose:#ff5f72;--hf-purple:#b388ff;
}
[data-theme="dark"]{
  --bg:#080b10;--surface:#0d1117;--surface2:#111820;
  --border:#1e2d3d;--text:#ccd6f6;--muted:#4a5568;
  --accent:#00e5ff;--accent-bg:rgba(0,229,255,0.08);--accent-light:#00e5ff;
  --danger:#ff4444;
  --ink:#ccd6f6;--paper:#080b10;--paper2:#0d1117;--card-bg:#111820;
  --shadow:0 4px 32px rgba(0,0,0,0.7);
  --vermillion:#ff6b35;--gold:#ffd700;--cl-muted:#4a5568;--jade:#3dba6e;
}
html,body{height:100%;background:var(--bg);color:var(--text);font-family:'Syne',sans-serif;overflow-x:hidden;-webkit-text-size-adjust:100%}
button,a,[onclick]{-webkit-tap-highlight-color:transparent;touch-action:manipulation}
.screen{display:none;flex-direction:column;min-height:100dvh}
.screen.active{display:flex}

/* SETUP */
#setup{padding:64px 28px 44px;gap:20px;justify-content:center}
.big-title{font-size:34px;font-weight:800;line-height:1.08}
.big-title span{color:var(--accent)}
.sub{font-size:13px;color:var(--muted);line-height:1.65;font-family:'DM Mono',monospace;font-weight:300}
.field-label{font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;margin-bottom:6px}
input[type=text],input[type=password],input[type=number],input[type=url],input[type=date],select,textarea{width:100%;background:var(--card-bg);border:1.5px solid var(--border);border-radius:14px;padding:12px 14px;color:var(--text);font-family:'DM Mono',monospace;font-size:15px;outline:none;transition:border-color .2s;-webkit-appearance:none;box-shadow:0 1px 3px rgba(0,0,0,.04)}
input:focus,select:focus,textarea:focus{border-color:var(--accent-light)}
input::placeholder,textarea::placeholder{color:var(--muted)}
textarea{resize:vertical;min-height:70px;font-family:'DM Sans',sans-serif}
.btn{background:var(--accent);color:#faf7f2;border:none;border-radius:14px;padding:16px;font-family:'Syne',sans-serif;font-size:15px;font-weight:800;cursor:pointer;width:100%;transition:transform .15s,opacity .15s}
.btn:active{transform:scale(.97);opacity:.9}
.help-link{font-size:12px;color:var(--muted);text-align:center;text-decoration:underline;cursor:pointer;font-family:'DM Mono',monospace}

/* DASHBOARD */
#dashboard{padding:0;overflow-y:auto;background:var(--bg)}
.dash-header{padding:52px 22px 16px;display:flex;justify-content:space-between;align-items:flex-start;flex-shrink:0}
.dash-logo{display:flex;flex-direction:column;gap:2px}
.dash-logo-tag{font-size:10px;letter-spacing:.2em;text-transform:uppercase;color:var(--accent);font-weight:700;font-family:'DM Mono',monospace}
.dash-title{font-size:26px;font-weight:800;letter-spacing:-.5px}
.dash-title span{color:var(--accent)}
.dash-subtitle{font-size:11px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:300;margin-top:2px}
.dash-actions{display:flex;gap:8px;align-items:center}
.ld-icon-btn{width:40px;height:40px;background:var(--card-bg);border:1px solid var(--border);border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:16px;box-shadow:0 1px 3px rgba(0,0,0,.06);transition:background .12s,transform .12s;flex-shrink:0}
.ld-icon-btn:active{background:var(--surface);transform:scale(.93)}

/* Event banner with points pill */
.event-banner{margin:0 18px 14px;background:linear-gradient(135deg,#c0392b,#8b1a10);border-radius:18px;padding:14px 18px;display:flex;align-items:center;gap:14px;cursor:pointer;flex-shrink:0;transition:transform .15s,box-shadow .15s;box-shadow:0 4px 16px rgba(192,57,43,.25);overflow:hidden;position:relative}
.event-banner::before{content:'';position:absolute;top:-40px;right:-40px;width:120px;height:120px;background:rgba(255,255,255,.06);border-radius:50%;pointer-events:none}
.event-banner:active{transform:scale(.98)}
.event-banner.hidden{display:none}
.evb-left{flex:1;min-width:0}
.evb-tag{font-size:9px;letter-spacing:.18em;text-transform:uppercase;color:rgba(255,255,255,.6);font-family:'DM Mono',monospace;margin-bottom:3px}
.evb-name{font-size:15px;font-weight:800;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;letter-spacing:-.2px}
.evb-sub{font-size:10px;color:rgba(255,255,255,.55);font-family:'DM Mono',monospace;margin-top:3px}
.evb-pts-pill{display:flex;align-items:center;gap:5px;background:rgba(255,255,255,.12);border:1px solid rgba(255,255,255,.2);border-radius:10px;padding:4px 9px;margin-top:6px;width:fit-content}
.evb-pts-ico{font-size:11px}
.evb-pts-val{font-size:11px;font-weight:800;color:#fff;font-family:'DM Mono',monospace;letter-spacing:-.3px}
.evb-pts-lbl{font-size:9px;color:rgba(255,255,255,.6);font-family:'DM Mono',monospace}
.evb-right{flex-shrink:0;text-align:right}
.evb-days{font-size:32px;font-weight:800;color:#fff;letter-spacing:-1.5px;line-height:1}
.evb-days-label{font-size:9px;color:rgba(255,255,255,.55);font-family:'DM Mono',monospace;letter-spacing:.1em;text-transform:uppercase;margin-top:1px}
.evb-arrow{font-size:16px;color:rgba(255,255,255,.45);flex-shrink:0}

.dash-summary{margin:0 18px 16px;background:var(--accent);border-radius:20px;padding:18px 20px;display:flex;justify-content:space-between;align-items:center;flex-shrink:0}
.dash-sum-label{font-size:10px;color:rgba(250,247,242,.6);letter-spacing:.15em;text-transform:uppercase;font-family:'DM Mono',monospace;margin-bottom:4px}
.dash-sum-amount{font-size:36px;font-weight:800;color:#faf7f2;letter-spacing:-1.5px;line-height:1}
.dash-sum-count{font-size:11px;color:rgba(250,247,242,.6);font-family:'DM Mono',monospace;margin-top:4px}
.dash-sum-right{text-align:right}
.dash-sum-month{font-size:13px;font-weight:700;color:rgba(250,247,242,.85)}
.dash-sum-trend{font-size:10px;font-family:'DM Mono',monospace;color:rgba(250,247,242,.55);margin-top:4px}
.dash-charts-label{padding:0 20px;margin-bottom:10px;font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;flex-shrink:0}

.charts-carousel{display:none;overflow-x:auto;scroll-snap-type:x mandatory;scrollbar-width:none;-webkit-overflow-scrolling:touch;padding:0 18px;gap:12px;flex-shrink:0}
.charts-carousel::-webkit-scrollbar{display:none}
.charts-carousel.active{display:flex}
.carousel-chart-card{flex-shrink:0;width:calc(100vw - 52px);scroll-snap-align:start;background:var(--card-bg);border:1px solid var(--border);border-radius:22px;padding:20px;cursor:pointer;transition:transform .15s;box-shadow:0 1px 4px rgba(0,0,0,.05)}
.carousel-chart-label{font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;margin-bottom:14px;display:flex;justify-content:space-between;align-items:center}
.carousel-chart-label span{font-size:9px;background:var(--accent-bg);color:var(--accent);border-radius:6px;padding:3px 7px}
.cdots{display:flex;justify-content:center;gap:6px;margin-top:12px}
.cdot{width:6px;height:6px;border-radius:50%;background:var(--border);transition:background .2s,width .2s}
.cdot.on{background:var(--accent);width:16px;border-radius:3px}
.charts-grid{display:none;padding:0 18px;gap:12px;margin-bottom:4px}
.charts-grid.active{display:grid;grid-template-columns:1fr 1fr}
.chart-panel{background:var(--card-bg);border:1px solid var(--border);border-radius:22px;padding:20px;cursor:pointer;transition:transform .15s;box-shadow:0 1px 4px rgba(0,0,0,.05)}
.chart-panel:hover{transform:translateY(-2px)}
.chart-panel-label{font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;margin-bottom:14px;display:flex;justify-content:space-between;align-items:center}
.chart-panel-label span{font-size:9px;background:var(--accent-bg);color:var(--accent);border-radius:6px;padding:3px 7px}
.pie-wrap{display:flex;align-items:center;gap:14px}
.dash-legend{flex:1;display:flex;flex-direction:column;gap:6px;min-width:0}
.dash-legend-row{display:flex;align-items:center;gap:6px}
.dash-legend-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0}
.dash-legend-name{font-size:10px;font-weight:700;flex:1;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-transform:uppercase}
.dash-legend-pct{font-size:9px;font-family:'DM Mono',monospace;color:var(--muted);flex-shrink:0;min-width:60px}
.chart-empty-small{text-align:center;padding:24px 0;color:var(--muted);font-family:'DM Mono',monospace;font-size:11px}
.line-chart-wrap{position:relative;width:100%}

.apps-section{padding:0 18px;margin-top:18px;margin-bottom:4px}
.apps-label{font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;margin-bottom:12px}
.apps-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px}
.app-card{background:var(--card-bg);border:1px solid var(--border);border-radius:18px;padding:16px;display:flex;flex-direction:column;gap:8px;cursor:pointer;transition:transform .15s,box-shadow .15s;box-shadow:0 1px 3px rgba(0,0,0,.04)}
.app-card:active,.app-card:hover{transform:translateY(-2px);box-shadow:0 6px 18px rgba(139,99,64,.1)}
.app-card-ico{width:40px;height:40px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
.app-card-name{font-size:13px;font-weight:800;line-height:1.2}
.app-card-desc{font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:300;line-height:1.5}
.app-card-tag{font-size:9px;background:var(--accent-bg);color:var(--accent);border-radius:6px;padding:2px 7px;letter-spacing:.08em;font-weight:700;align-self:flex-start}
.dash-bottom-space{height:calc(40px + env(safe-area-inset-bottom,0px));flex-shrink:0}

/* SPENDLY */
.sp-header{padding:52px 22px 14px;display:flex;justify-content:space-between;align-items:flex-start;flex-shrink:0}
.sp-greeting{font-size:22px;font-weight:800;letter-spacing:-.3px}
.sp-header-btns{display:flex;gap:8px;align-items:center}
.sp-icon-btn{width:40px;height:40px;background:var(--card-bg);border:1px solid var(--border);border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:16px;box-shadow:0 1px 3px rgba(0,0,0,.06);transition:background .12s,transform .12s;flex-shrink:0}
.sp-icon-btn:active{background:var(--surface);transform:scale(.93)}
.sp-icon-btn.spinning{animation:spin .8s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.sync-bar{margin:0 18px 10px;display:flex;align-items:center;gap:6px;font-size:11px;font-family:'DM Mono',monospace;color:var(--muted)}
.sync-dot{width:7px;height:7px;border-radius:50%;background:var(--muted);flex-shrink:0}
.sync-dot.ok{background:#3a7a3a}.sync-dot.err{background:var(--danger)}
.sync-dot.syncing{background:var(--accent-light);animation:pulse .8s ease-in-out infinite}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.4}}
.month-card{margin:0 18px 14px;background:var(--accent);border-radius:22px;padding:22px 24px;position:relative;overflow:hidden;flex-shrink:0;cursor:pointer}
.month-card::before{content:'';position:absolute;top:-60px;right:-60px;width:180px;height:180px;background:rgba(255,255,255,.06);border-radius:50%;pointer-events:none}
.month-lbl{font-size:10px;color:rgba(250,247,242,.6);letter-spacing:.15em;text-transform:uppercase;font-family:'DM Mono',monospace}
.month-total{font-size:46px;font-weight:800;color:#faf7f2;letter-spacing:-2px;line-height:1}
.month-cur{font-size:22px;vertical-align:super;letter-spacing:0}
.month-count{font-size:11px;color:rgba(250,247,242,.6);font-family:'DM Mono',monospace;margin-top:6px}
.month-row{background:var(--card-bg);border:1px solid var(--border);border-radius:14px;padding:14px 16px;display:flex;align-items:center;justify-content:space-between;cursor:pointer;transition:background .12s}
.month-row:active{background:var(--surface)}
.month-row.current{border-color:var(--accent-light);background:var(--accent-bg)}
.month-row-label{font-size:14px;font-weight:700}
.month-row-meta{font-size:12px;font-family:'DM Mono',monospace;color:var(--muted)}
.month-row-amt{font-size:14px;font-family:'DM Mono',monospace;color:var(--accent);font-weight:700}
.legend{flex:1;display:flex;flex-direction:column;gap:7px;min-width:0}
.legend-row{display:flex;align-items:center;gap:7px;cursor:pointer;border-radius:8px;padding:2px 4px;transition:background .12s}
.legend-dot{width:9px;height:9px;border-radius:50%;flex-shrink:0}
.legend-name{font-size:11px;font-weight:700;flex:1;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;text-transform:uppercase}
.legend-amt{font-size:10px;font-family:'DM Mono',monospace;color:var(--muted);flex-shrink:0;margin-right:4px}
.legend-pct{font-size:10px;font-family:'DM Mono',monospace;color:var(--muted);flex-shrink:0;min-width:28px;text-align:right}
.section-hdr{padding:0 20px;margin-bottom:10px;font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;flex-shrink:0}
.filter-row{display:flex;gap:7px;padding:0 18px;margin-bottom:12px;overflow-x:auto;scrollbar-width:none;flex-shrink:0}
.filter-row::-webkit-scrollbar{display:none}
.fpill{flex-shrink:0;background:var(--card-bg);border:1px solid var(--border);border-radius:20px;padding:6px 13px;font-size:11px;font-weight:700;color:var(--muted);cursor:pointer;transition:all .12s}
.fpill.on{background:var(--accent-bg);color:var(--accent);border-color:var(--accent-light)}
.txn-list{padding:0 18px;display:flex;flex-direction:column;gap:8px;padding-bottom:100px}
.txn{background:var(--card-bg);border:1px solid var(--border);border-radius:16px;padding:13px 15px;display:flex;align-items:center;gap:12px;box-shadow:0 1px 3px rgba(0,0,0,.04)}
.txn-ico{width:40px;height:40px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0}
.txn-info{flex:1;min-width:0}
.txn-name{font-size:14px;font-weight:700;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.txn-sub{font-size:10px;color:var(--muted);font-family:'DM Mono',monospace;margin-top:2px}
.txn-amt{font-family:'DM Mono',monospace;font-size:14px;font-weight:400;flex-shrink:0}
.del-btn{background:none;border:none;color:var(--muted);font-size:14px;cursor:pointer;padding:4px;opacity:.4;flex-shrink:0}
.del-btn:active{opacity:1;color:var(--danger)}
.empty{text-align:center;padding:48px 20px;color:var(--muted);font-family:'DM Mono',monospace;font-size:13px;line-height:1.9}
.empty .ico{font-size:36px;display:block;margin-bottom:10px}
.sp-fab{position:fixed;bottom:calc(24px + env(safe-area-inset-bottom,0px));right:20px;width:58px;height:58px;background:var(--accent);border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:30px;color:#faf7f2;cursor:pointer;box-shadow:0 4px 20px rgba(139,99,64,.3);border:none;font-weight:700;line-height:1}
.sp-fab:active{transform:scale(.93)}

/* Spendly settings */
.sp-settings-row{display:flex;align-items:center;justify-content:space-between;padding:14px 0;border-bottom:1px solid var(--border)}
.sp-settings-label{font-size:14px;font-weight:700;font-family:'Syne',sans-serif}
.sp-settings-sub{font-size:11px;color:var(--muted);font-family:'DM Mono',monospace;font-weight:300;margin-top:2px}
.sp-toggle-switch{position:relative;width:44px;height:24px;background:var(--surface2);border-radius:12px;cursor:pointer;transition:background .3s;border:1px solid var(--border);flex-shrink:0}
.sp-toggle-switch.on{background:var(--accent)}
.sp-toggle-switch::after{content:'';position:absolute;top:3px;left:3px;width:16px;height:16px;background:#fff;border-radius:50%;transition:left .3s}
.sp-toggle-switch.on::after{left:23px}
.sp-export-btn{display:flex;align-items:center;gap:8px;padding:11px 15px;border-radius:10px;border:1.5px solid var(--border);background:none;color:var(--text);cursor:pointer;font-size:13px;font-family:'Syne',sans-serif;font-weight:700;transition:all .12s;width:100%;margin-bottom:8px}
.sp-export-btn:active{background:var(--accent-bg);border-color:var(--accent-light)}
.sp-settings-section-lbl{font-size:10px;letter-spacing:.15em;text-transform:uppercase;color:var(--muted);font-weight:700;margin:18px 0 10px;font-family:'DM Mono',monospace}
.sp-db-card{background:var(--surface);border-radius:14px;padding:16px;margin-top:4px}
.sp-db-status{font-size:13px;font-weight:700;font-family:'Syne',sans-serif;margin-bottom:4px}
.sp-db-url{font-size:11px;color:var(--muted);word-break:break-all;font-family:'DM Mono',monospace;margin-bottom:10px}
.sp-db-btn{display:inline-flex;align-items:center;gap:6px;padding:7px 13px;border-radius:8px;border:1.5px solid var(--border);background:none;color:var(--text);cursor:pointer;font-size:12px;font-family:'Syne',sans-serif;font-weight:700;transition:all .12s;margin-right:6px;margin-top:4px}
.sp-db-btn:active{background:var(--accent-bg)}
.sp-db-btn.danger{border-color:rgba(192,57,43,.4);color:var(--danger)}
.sp-debug-log{display:none;margin-top:10px;background:var(--card-bg);border:1px solid var(--border);border-radius:8px;padding:10px;font-size:11px;font-family:'DM Mono',monospace;color:var(--text);max-height:140px;overflow-y:auto;line-height:1.6;white-space:pre-wrap}

/* Overlays / Modals (Spendly) */
.sp-overlay{display:none;position:fixed;inset:0;background:rgba(42,31,15,.4);backdrop-filter:blur(6px);z-index:400;align-items:flex-end}
.sp-overlay.open{display:flex}
.sp-modal{background:var(--bg);border-radius:28px 28px 0 0;border:1px solid var(--border);border-bottom:none;padding:12px 22px calc(28px + env(safe-area-inset-bottom,0px));width:100%;max-height:85dvh;overflow-y:auto}
.sp-handle{width:36px;height:4px;background:var(--border);border-radius:2px;margin:0 auto 18px}
.sp-modal-title{font-size:20px;font-weight:800;margin-bottom:16px}
.sp-modal-lbl{font-size:10px;color:var(--muted);letter-spacing:.12em;text-transform:uppercase;font-weight:700;margin-bottom:6px;display:block}
.amt-wrap{position:relative;margin-bottom:14px}
.amt-prefix{position:absolute;left:16px;top:50%;transform:translateY(-50%);font-size:22px;font-weight:800;color:var(--accent-light);font-family:'DM Mono',monospace;pointer-events:none}
#sp-amt-input{width:100%;background:var(--card-bg);border:2px solid var(--accent-light);border-radius:16px;padding:16px 16px 16px 44px;font-family:'DM Mono',monospace;font-size:32px;font-weight:800;color:var(--accent);outline:none;-webkit-appearance:none;letter-spacing:-1px}
#sp-amt-input:focus{border-color:var(--accent)}
.cat-grid-modal{display:grid;grid-template-columns:repeat(4,1fr);gap:7px;margin-bottom:16px}
.cbtn{background:var(--card-bg);border:1px solid var(--border);border-radius:12px;padding:8px 4px;font-family:'Syne',sans-serif;font-size:9px;font-weight:700;color:var(--muted);cursor:pointer;display:flex;flex-direction:column;align-items:center;gap:3px;transition:all .12s;text-transform:uppercase;letter-spacing:.03em;line-height:1.2;text-align:center}
.cbtn .cico{font-size:18px;display:flex;align-items:center;justify-content:center;height:22px}
.cbtn.on{background:var(--accent-bg);color:var(--accent);border-color:var(--accent-light)}

/* Guide */
#guide{padding:56px 22px 40px;gap:16px;overflow-y:auto}
.gback{font-size:13px;color:var(--accent);cursor:pointer;font-weight:700}
.gtitle{font-size:28px;font-weight:800;line-height:1.15;margin-bottom:4px}
.gstep{background:var(--card-bg);border:1px solid var(--border);border-radius:18px;padding:16px;margin-bottom:8px}
.snum{font-size:9px;letter-spacing:.15em;text-transform:uppercase;color:var(--accent);font-weight:700;font-family:'DM Mono',monospace;margin-bottom:4px}
.stitle{font-size:14px;font-weight:700;margin-bottom:6px}
.sdesc{font-size:12px;color:var(--muted);line-height:1.65;font-family:'DM Mono',monospace;font-weight:300}
.code-box{background:var(--surface);border-radius:10px;padding:10px 13px;margin-top:10px;font-family:'DM Mono',monospace;font-size:11px;color:var(--accent);line-height:1.8;word-break:break-all}

/* CHRONOLUNA */
#chronoluna{background:var(--paper);color:var(--ink);font-family:'DM Sans',sans-serif;overflow-y:auto}
#chronoluna header{display:flex;align-items:center;justify-content:space-between;padding:18px 22px 14px;background:var(--paper);border-bottom:2px solid var(--gold);position:sticky;top:0;z-index:100;backdrop-filter:blur(8px)}
.cl-logo-text{font-family:'Playfair Display',serif;font-size:1.25rem;font-weight:900;color:var(--vermillion);letter-spacing:-.5px}
.cl-logo-sub{font-size:.7rem;color:var(--cl-muted);letter-spacing:2px;text-transform:uppercase;display:block}
.cl-header-actions{display:flex;gap:8px;align-items:center}
.cl-icon-btn{background:var(--paper2);border:1.5px solid var(--gold);color:var(--ink);border-radius:50%;width:40px;height:40px;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:18px;transition:var(--transition);flex-shrink:0}
.cl-icon-btn:hover{background:var(--gold);color:#fff}
.sb-indicator{display:flex;align-items:center;gap:6px;padding:5px 11px;border-radius:20px;font-size:.72rem;letter-spacing:.5px;border:1.5px solid var(--paper2);cursor:pointer;transition:var(--transition);white-space:nowrap}
.sb-indicator .dot{width:7px;height:7px;border-radius:50%}
.sb-indicator.connected .dot{background:var(--jade)}
.sb-indicator.local .dot{background:var(--gold)}
.sb-indicator.connected{border-color:rgba(46,139,87,.3)}
#cl-next-banner{background:linear-gradient(135deg,var(--vermillion),#8b1a10);color:#fff;padding:12px 22px;display:flex;align-items:center;gap:14px;font-size:.9rem;cursor:pointer;border-bottom:2px solid var(--gold);transition:opacity .3s}
#cl-next-banner .banner-label{font-size:.7rem;letter-spacing:2px;text-transform:uppercase;opacity:.8;display:block}
#cl-next-banner .banner-name{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700}
#cl-next-banner .banner-count{margin-left:auto;text-align:right}
#cl-next-banner .banner-days{font-size:2rem;font-weight:900;line-height:1}
#cl-next-banner.hidden{display:none}
.cl-section-title{font-family:'Playfair Display',serif;font-size:1.05rem;color:var(--cl-muted);letter-spacing:1px;padding:0 22px 14px;display:flex;align-items:center;gap:10px}
.cl-section-title::after{content:'';flex:1;height:1px;background:var(--gold);opacity:.4}
#cl-carousel-section{padding:24px 0 8px}
.cl-carousel-track{display:flex;gap:16px;padding:8px 22px 18px;overflow-x:auto;scroll-snap-type:x mandatory;scroll-behavior:smooth;-webkit-overflow-scrolling:touch;scrollbar-width:none}
.cl-carousel-track::-webkit-scrollbar{display:none}
.event-card{min-width:280px;max-width:300px;flex-shrink:0;scroll-snap-align:start;background:var(--card-bg);border-radius:var(--radius);border:1.5px solid var(--gold);box-shadow:var(--shadow);padding:20px 18px 16px;position:relative;overflow:hidden;transition:transform .25s;cursor:pointer}
.event-card:hover{transform:translateY(-4px)}
.event-card::before{content:'';position:absolute;top:0;left:0;right:0;height:4px;background:var(--cat-color,var(--gold))}
.card-cat-icon{font-size:2.2rem;margin-bottom:8px;display:block}
.card-name{font-family:'Playfair Display',serif;font-size:1.15rem;font-weight:700;margin-bottom:4px}
.card-lunar{font-size:.75rem;color:var(--cl-muted);margin-bottom:10px;font-family:'Noto Serif SC',serif}
.card-countdown{display:grid;grid-template-columns:repeat(4,1fr);gap:6px;margin-bottom:12px}
.countdown-unit{text-align:center;background:var(--paper2);border-radius:8px;padding:7px 3px}
.countdown-num{font-size:1.5rem;font-weight:900;line-height:1;color:var(--vermillion);display:block}
.countdown-label{font-size:.58rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted)}
.card-footer{display:flex;align-items:center;justify-content:space-between}
.card-date{font-size:.75rem;color:var(--cl-muted)}
.card-actions{display:flex;gap:6px}
.card-action-btn{background:none;border:1px solid var(--gold);border-radius:50%;width:28px;height:28px;cursor:pointer;color:var(--ink);display:flex;align-items:center;justify-content:center;font-size:13px;transition:var(--transition)}
.card-action-btn:hover{background:var(--vermillion);border-color:var(--vermillion);color:#fff}
.card-celebrated{opacity:.55}
.card-celebrated::after{content:'Today!';position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:1.3rem;font-family:'Playfair Display',serif;font-weight:700;background:rgba(192,57,43,.12);color:var(--vermillion);border-radius:var(--radius)}
.empty-carousel{padding:36px 22px;text-align:center;color:var(--cl-muted);font-size:.9rem;width:100%}
#cl-list-section{padding:8px 22px 110px}
.filter-tabs{display:flex;gap:8px;padding:0 0 14px;overflow-x:auto;scrollbar-width:none}
.filter-tabs::-webkit-scrollbar{display:none}
.filter-tab{flex-shrink:0;padding:6px 13px;border-radius:20px;border:1.5px solid var(--paper2);background:none;cursor:pointer;font-size:.78rem;color:var(--cl-muted);transition:var(--transition);font-family:'DM Sans',sans-serif}
.filter-tab.active{background:var(--ink);color:var(--paper);border-color:var(--ink)}
.event-list-item{display:flex;align-items:center;gap:14px;background:var(--card-bg);border-radius:12px;border:1px solid var(--paper2);padding:13px 15px;margin-bottom:10px;cursor:pointer;transition:var(--transition)}
.event-list-item:hover{border-color:var(--gold);transform:translateX(4px)}
.list-icon{font-size:1.5rem;flex-shrink:0}
.list-info{flex:1;min-width:0}
.list-name{font-weight:500;font-size:.93rem;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-family:'DM Sans',sans-serif}
.list-date{font-size:.73rem;color:var(--cl-muted);font-family:'DM Sans',sans-serif}
.list-days{font-family:'Playfair Display',serif;font-size:1.25rem;font-weight:700;color:var(--vermillion);flex-shrink:0}
.list-days.past{color:var(--cl-muted)}
.cl-fab{position:fixed;bottom:max(28px,env(safe-area-inset-bottom,28px));right:22px;background:var(--vermillion);color:#fff;border:none;border-radius:50px;padding:13px 20px;font-size:1rem;font-family:'DM Sans',sans-serif;font-weight:500;cursor:pointer;box-shadow:0 6px 24px rgba(192,57,43,.45);display:flex;align-items:center;gap:8px;transition:var(--transition);z-index:200}

/* CL Modals */
.cl-overlay{position:fixed;inset:0;background:rgba(26,18,9,.6);backdrop-filter:blur(4px);z-index:500;display:flex;align-items:flex-end;justify-content:center;opacity:0;pointer-events:none;transition:opacity .3s}
.cl-overlay.open{opacity:1;pointer-events:all}
.cl-modal{background:var(--paper);border-radius:24px 24px 0 0;padding:24px 22px max(36px,env(safe-area-inset-bottom,36px));width:100%;max-width:520px;transform:translateY(60px);transition:transform .4s cubic-bezier(.4,0,.2,1);max-height:92dvh;overflow-y:auto;overflow-x:hidden;font-family:'DM Sans',sans-serif}
.cl-overlay.open .cl-modal{transform:translateY(0)}
.modal-handle{width:42px;height:4px;background:var(--gold);border-radius:2px;margin:0 auto 18px}
.cl-modal-title{font-family:'Playfair Display',serif;font-size:1.35rem;font-weight:700;margin-bottom:20px;color:var(--ink)}
.form-group{margin-bottom:15px}
.form-group label{display:block;font-size:.75rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted);margin-bottom:6px;font-family:'DM Sans',sans-serif}
.cat-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:8px}
.cat-btn{background:var(--paper2);border:2px solid transparent;border-radius:10px;padding:8px 3px;cursor:pointer;text-align:center;font-size:1.2rem;transition:var(--transition)}
.cat-btn.selected{border-color:var(--gold);background:var(--card-bg)}
.cat-btn span{display:block;font-size:.58rem;color:var(--cl-muted);margin-top:2px}
.lunar-display{background:var(--paper2);border-radius:10px;padding:10px 13px;font-family:'Noto Serif SC',serif;font-size:.85rem;color:var(--jade);min-height:36px;display:flex;align-items:center}
.cl-toggle-group{display:flex;border:1.5px solid var(--gold);border-radius:10px;overflow:hidden}
.cl-toggle-btn{flex:1;padding:9px 4px;border:none;background:none;cursor:pointer;font-family:'DM Sans',sans-serif;font-size:.8rem;color:var(--cl-muted);transition:var(--transition);border-right:1px solid var(--gold)}
.cl-toggle-btn:last-child{border-right:none}
.cl-toggle-btn.active{background:var(--gold);color:var(--ink);font-weight:600}
.notif-grid{display:flex;flex-wrap:wrap;gap:8px}
.notif-chip{display:flex;align-items:center;gap:6px;background:var(--paper2);border:1.5px solid var(--paper2);border-radius:20px;padding:6px 13px;cursor:pointer;font-size:.78rem;transition:all .18s;user-select:none;position:relative;font-family:'DM Sans',sans-serif}
.notif-chip::before{content:'';width:7px;height:7px;border-radius:50%;background:var(--cl-muted);flex-shrink:0;transition:all .18s}
.notif-chip.selected{background:rgba(46,139,87,.13);border-color:var(--jade);color:var(--jade);font-weight:500}
.notif-chip.selected::before{background:var(--jade)}
.notif-chip input{display:none}
.btn-primary{width:100%;padding:14px;background:var(--vermillion);color:#fff;border:none;border-radius:12px;font-family:'DM Sans',sans-serif;font-size:1rem;font-weight:600;cursor:pointer;transition:var(--transition);margin-top:8px}
.btn-primary:hover{background:#a93226}
.btn-secondary{width:100%;padding:12px;background:none;color:var(--cl-muted);border:1.5px solid var(--paper2);border-radius:12px;font-family:'DM Sans',sans-serif;font-size:.9rem;cursor:pointer;margin-top:6px}
.btn-secondary:hover{border-color:var(--vermillion);color:var(--vermillion)}
.detail-card-big{background:var(--paper2);border-radius:16px;padding:20px;margin-bottom:16px;text-align:center}
.detail-event-name{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:900;margin:8px 0 4px;color:var(--ink)}
.detail-countdown-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin:16px 0}
.detail-unit{background:var(--card-bg);border-radius:12px;padding:12px 6px;text-align:center}
.detail-num{font-size:2.2rem;font-weight:900;color:var(--vermillion);line-height:1;display:block}
.detail-label{font-size:.62rem;letter-spacing:2px;text-transform:uppercase;color:var(--cl-muted)}
.share-btn{display:inline-flex;align-items:center;gap:7px;padding:9px 18px;border-radius:20px;border:1.5px solid var(--gold);background:none;color:var(--ink);cursor:pointer;font-size:.85rem;transition:var(--transition);margin:4px;font-family:'DM Sans',sans-serif}
.share-btn:hover{background:var(--gold)}
.confetti-container{position:fixed;inset:0;pointer-events:none;z-index:700}
.confetti-piece{position:absolute;width:10px;height:10px;border-radius:2px;animation:confetti-fall 3s ease-in forwards;top:-20px}
@keyframes confetti-fall{0%{transform:translateY(0) rotate(0deg);opacity:1}100%{transform:translateY(105vh) rotate(720deg);opacity:0}}
.settings-row{display:flex;align-items:center;justify-content:space-between;padding:14px 0;border-bottom:1px solid var(--paper2)}
.settings-label{font-size:.9rem;font-family:'DM Sans',sans-serif}
.settings-sub{font-size:.75rem;color:var(--cl-muted);font-family:'DM Sans',sans-serif}
.toggle-switch{position:relative;width:44px;height:24px;background:var(--paper2);border-radius:12px;cursor:pointer;transition:background .3s;border:1px solid var(--gold)}
.toggle-switch.on{background:var(--jade)}
.toggle-switch::after{content:'';position:absolute;top:3px;left:3px;width:16px;height:16px;background:#fff;border-radius:50%;transition:left .3s}
.toggle-switch.on::after{left:23px}
.export-btn{display:flex;align-items:center;gap:8px;padding:11px 15px;border-radius:10px;border:1.5px solid var(--gold);background:none;color:var(--ink);cursor:pointer;font-size:.86rem;transition:var(--transition);width:100%;margin-bottom:8px;font-family:'DM Sans',sans-serif}
.export-btn:hover{background:var(--gold)}
.sb-settings-card{background:var(--paper2);border-radius:14px;padding:16px;margin-top:14px}
.sb-settings-url{font-size:.76rem;color:var(--cl-muted);word-break:break-all;margin:6px 0 10px;font-family:monospace}
.sb-reconnect-btn{display:inline-flex;align-items:center;gap:6px;padding:7px 13px;border-radius:8px;border:1.5px solid var(--gold);background:none;color:var(--ink);cursor:pointer;font-size:.8rem;margin-right:8px;margin-top:4px;font-family:'DM Sans',sans-serif}
.sb-reconnect-btn:hover{background:var(--gold)}
.sb-disconnect-btn{display:inline-flex;align-items:center;gap:6px;padding:7px 13px;border-radius:8px;border:1.5px solid rgba(192,57,43,.4);background:none;color:var(--vermillion);cursor:pointer;font-size:.8rem;margin-top:4px;font-family:'DM Sans',sans-serif}
.sb-disconnect-btn:hover{background:rgba(192,57,43,.1)}
#cl-supabase-overlay{position:fixed;inset:0;z-index:900;background:var(--paper);display:flex;flex-direction:column;align-items:center;justify-content:flex-start;padding:16px 12px;overflow-y:auto;opacity:0;pointer-events:none;transition:opacity .4s}
#cl-supabase-overlay.open{opacity:1;pointer-events:all}
.sb-modal-inner{width:100%;max-width:440px;background:var(--card-bg);border:1.5px solid var(--gold);border-radius:24px;padding:32px 26px 26px;box-shadow:var(--shadow)}
.sb-logo{text-align:center;margin-bottom:22px}
.sb-logo-icon{font-size:3rem;display:block;margin-bottom:8px}
.sb-logo-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:900;color:var(--vermillion)}
.sb-logo-sub{font-size:.76rem;color:var(--cl-muted);letter-spacing:2px;text-transform:uppercase;margin-top:4px;font-family:'DM Sans',sans-serif}
.sb-divider{display:flex;align-items:center;gap:10px;margin:18px 0 16px;color:var(--cl-muted);font-size:.76rem;font-family:'DM Sans',sans-serif}
.sb-divider::before,.sb-divider::after{content:'';flex:1;height:1px;background:var(--gold);opacity:.4}
.sb-info-box{background:var(--paper2);border-radius:12px;padding:12px 14px;font-size:.78rem;color:var(--cl-muted);line-height:1.6;margin-bottom:16px;font-family:'DM Sans',sans-serif}
.sb-input-wrap{position:relative;margin-bottom:14px}
.sb-input-wrap label{display:block;font-size:.7rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted);margin-bottom:5px;font-family:'DM Sans',sans-serif}
.sb-status{display:flex;align-items:center;gap:8px;font-size:.8rem;padding:10px 13px;border-radius:10px;margin-bottom:12px;display:none;font-family:'DM Sans',sans-serif}
.sb-status.success{background:rgba(46,139,87,.12);color:var(--jade);display:flex}
.sb-status.error{background:rgba(192,57,43,.1);color:var(--vermillion);display:flex}
.sb-status.loading{background:var(--paper2);color:var(--cl-muted);display:flex}
.sb-status-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0;background:currentColor}
.sb-status.loading .sb-status-dot{animation:pulse-dot 1s infinite}
@keyframes pulse-dot{0%,100%{opacity:1}50%{opacity:.3}}
.sb-btn-connect{width:100%;padding:13px;background:var(--vermillion);color:#fff;border:none;border-radius:12px;font-family:'DM Sans',sans-serif;font-size:1rem;font-weight:600;cursor:pointer;margin-bottom:10px;display:flex;align-items:center;justify-content:center;gap:8px}
.sb-btn-connect:hover{background:#a93226}
.sb-btn-connect:disabled{opacity:.6;cursor:not-allowed}
.sb-btn-local{width:100%;padding:11px;background:none;color:var(--cl-muted);border:1.5px solid var(--paper2);border-radius:12px;font-family:'DM Sans',sans-serif;font-size:.86rem;cursor:pointer}
.sb-btn-local:hover{border-color:var(--gold);color:var(--ink)}
.sb-privacy{text-align:center;font-size:.7rem;color:var(--cl-muted);margin-top:12px;line-height:1.5;font-family:'DM Sans',sans-serif}
#cl-toast{position:fixed;bottom:calc(90px + env(safe-area-inset-bottom,0px));left:50%;transform:translateX(-50%) translateY(20px);background:var(--ink);color:var(--paper);padding:10px 20px;border-radius:20px;font-size:.85rem;z-index:800;opacity:0;transition:opacity .3s,transform .3s;pointer-events:none;white-space:nowrap;max-width:90vw;text-align:center;font-family:'DM Sans',sans-serif}
#cl-toast.show{opacity:1;transform:translateX(-50%) translateY(0)}
.sp-toast{position:fixed;top:60px;left:50%;transform:translateX(-50%) translateY(-16px);color:#faf7f2;border-radius:12px;padding:9px 18px;font-size:12px;font-family:'DM Mono',monospace;white-space:nowrap;opacity:0;transition:all .3s;z-index:600;pointer-events:none}
.sp-toast.show{opacity:1;transform:translateX(-50%) translateY(0)}
.sp-toast.ok{background:var(--accent)}
.sp-toast.err{background:var(--danger)}

/* HABITFORGE */
#habitforge{background:var(--hf-bg);color:var(--hf-tx);font-family:'Bricolage Grotesque',sans-serif;overflow-y:auto}
.hf-screen{position:relative;z-index:1;display:flex;min-height:100dvh}
.hf-sb{width:210px;flex-shrink:0;background:var(--hf-bg2);border-right:1px solid var(--hf-ln);display:flex;flex-direction:column;position:sticky;top:0;height:100dvh;overflow-y:auto}
.hf-sb-top{display:flex;align-items:center;gap:.5rem;padding:1.1rem 1rem .8rem;font-size:.88rem;font-weight:800;letter-spacing:-.02em;border-bottom:1px solid var(--hf-ln)}
.hf-brand-box{width:22px;height:22px;background:var(--hf-lime);border-radius:5px;display:grid;place-items:center;font-size:.66rem;font-weight:900;color:#080c0e;box-shadow:0 0 12px rgba(127,255,106,.3);flex-shrink:0}
.hf-back-btn{font-size:10px;color:var(--hf-lime);font-weight:700;letter-spacing:.12em;text-transform:uppercase;font-family:'DM Mono',monospace;cursor:pointer;padding:6px 1rem;border-bottom:1px solid var(--hf-ln);width:100%;text-align:left;background:none;border-left:none;border-right:none;border-top:none;opacity:.7}
.hf-back-btn:hover{opacity:1}
.hf-nav{display:flex;flex-direction:column;gap:.1rem;padding:.6rem .5rem;flex:1}
.hf-nb{display:flex;align-items:center;gap:.45rem;background:none;border:none;border-radius:7px;color:var(--hf-tx2);padding:.48rem .65rem;font-family:'Bricolage Grotesque',sans-serif;font-size:.78rem;font-weight:600;cursor:pointer;transition:.12s;text-align:left;width:100%}
.hf-nb:hover{background:var(--hf-bg3);color:var(--hf-tx)}
.hf-nb.on{background:rgba(127,255,106,.08);color:var(--hf-lime)}
.hf-sb-foot{padding:.75rem .9rem;border-top:1px solid var(--hf-ln);display:flex;align-items:center;gap:.55rem}
.hf-sb-pts{flex:1;font-size:.68rem;color:var(--hf-tx2);font-family:'DM Mono',monospace}
.hf-sb-pts strong{color:var(--hf-lime);font-size:.82rem;display:block}
.hf-main{flex:1;overflow-y:auto;padding:1.5rem 1.75rem;min-height:100dvh}
.hf-view{display:none}
.hf-view.on{display:block}
.hf-vhdr{display:flex;align-items:center;justify-content:space-between;gap:.75rem;margin-bottom:1.4rem;flex-wrap:wrap}
.hf-vhdr h2{font-size:1.38rem;font-weight:800;letter-spacing:-.04em;color:var(--hf-tx)}
.hf-vhdr-r{display:flex;align-items:center;gap:.55rem;flex-wrap:wrap}
.hf-datetag{font-family:'DM Mono',monospace;font-size:.68rem;color:var(--hf-tx2);background:var(--hf-bg3);border:1px solid var(--hf-ln);border-radius:6px;padding:.23rem .55rem}
.hf-slabel{font-size:.62rem;font-weight:700;text-transform:uppercase;letter-spacing:.1em;color:var(--hf-tx3);margin:1.1rem 0 .55rem}
.hf-btn-green{background:var(--hf-lime);color:#080c0e;border:none;border-radius:8px;padding:.48rem 1.05rem;font-family:'Bricolage Grotesque',sans-serif;font-size:.78rem;font-weight:700;cursor:pointer;transition:.13s}
.hf-btn-green:hover{background:var(--hf-lime2)}
.hf-btn-ghost{background:transparent;border:1px solid var(--hf-ln2);color:var(--hf-tx2);border-radius:8px;padding:.46rem .95rem;font-size:.76rem;font-family:'Bricolage Grotesque',sans-serif;font-weight:600;cursor:pointer;transition:.12s}
.hf-btn-ghost:hover{border-color:var(--hf-tx2);color:var(--hf-tx)}
.hf-btn-muted{background:var(--hf-bg3);border:1px solid var(--hf-ln2);color:var(--hf-tx2);border-radius:8px;padding:.31rem .66rem;font-size:.68rem;font-weight:600;font-family:'Bricolage Grotesque',sans-serif;cursor:pointer;transition:.12s}
.hf-btn-muted:hover{border-color:var(--hf-tx2);color:var(--hf-tx)}
.hf-btn-danger{background:rgba(255,95,114,.07);border:1px solid rgba(255,95,114,.2);color:var(--hf-rose);border-radius:8px;padding:.31rem .66rem;font-size:.68rem;font-weight:600;font-family:'Bricolage Grotesque',sans-serif;cursor:pointer;transition:.12s}
.hf-btn-danger:hover{background:rgba(255,95,114,.16)}
.hf-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:.7rem;margin-bottom:0}
.hf-sc{background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;padding:.85rem 1rem}
.hf-sc.hi{border-color:rgba(127,255,106,.2);background:rgba(127,255,106,.02)}
.hf-sc-v{font-size:1.45rem;font-weight:800;letter-spacing:-.04em;line-height:1;color:var(--hf-tx)}
.hf-sc.hi .hf-sc-v{color:var(--hf-lime)}
.hf-sc-l{font-size:.6rem;font-weight:700;text-transform:uppercase;letter-spacing:.07em;color:var(--hf-tx3);margin-top:.22rem}
.hf-hgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(175px,1fr));gap:.7rem}
.hf-hcard{background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;padding:.95rem;cursor:pointer;transition:border-color .15s,transform .15s}
.hf-hcard:hover{border-color:rgba(127,255,106,.35);transform:translateY(-2px)}
.hf-hcard.checked{border-color:rgba(127,255,106,.25);background:rgba(127,255,106,.015)}
.hf-hcard-top{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:.32rem}
.hf-hcard-emo{font-size:1.5rem}
.hf-edit-hint{font-size:.58rem;color:var(--hf-tx3);opacity:0;transition:.13s;font-family:'DM Mono',monospace}
.hf-hcard:hover .hf-edit-hint,.hf-ccard:hover .hf-edit-hint{opacity:1;color:var(--hf-lime)}
.hf-hcard-name{font-size:.81rem;font-weight:700;line-height:1.3;margin-bottom:.16rem;color:var(--hf-tx)}
.hf-hcard-streak{font-size:.66rem;color:var(--hf-amber);font-family:'DM Mono',monospace;margin-bottom:.07rem}
.hf-hcard-pts{font-size:.62rem;color:var(--hf-tx3)}
.hf-hcard-btn{display:block;width:100%;margin-top:.7rem;padding:.38rem;border-radius:6px;border:1px solid var(--hf-ln2);background:var(--hf-bg3);color:var(--hf-tx2);font-family:'Bricolage Grotesque',sans-serif;font-size:.68rem;font-weight:700;cursor:pointer;transition:.13s}
.hf-hcard-btn:hover:not(:disabled){border-color:var(--hf-lime);color:var(--hf-lime)}
.hf-hcard-btn.done{background:rgba(127,255,106,.07);color:var(--hf-lime);border-color:rgba(127,255,106,.22);cursor:default}
.hf-feed{display:flex;flex-direction:column;gap:.28rem}
.hf-feed-item{display:flex;align-items:center;gap:.52rem;padding:.48rem .75rem;background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:8px;font-size:.72rem;color:var(--hf-tx)}
.hf-feed-ico{font-size:.88rem;flex-shrink:0}
.hf-feed-tx{flex:1}
.hf-feed-dt{font-family:'DM Mono',monospace;font-size:.62rem;color:var(--hf-tx3)}
.hf-cgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(255px,1fr));gap:.8rem}
.hf-ccard{background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;padding:1.1rem;cursor:pointer;transition:border-color .15s,transform .15s}
.hf-ccard:hover{border-color:rgba(127,255,106,.35);transform:translateY(-2px)}
.hf-ccard-top{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:.7rem}
.hf-ccard-emo{font-size:1.75rem}
.hf-ccard-badges{display:flex;align-items:center;gap:.32rem}
.hf-cstatus{font-size:.56rem;font-weight:700;text-transform:uppercase;letter-spacing:.06em;padding:.13rem .38rem;border-radius:4px}
.hf-cs-on{background:rgba(127,255,106,.1);color:var(--hf-lime)}
.hf-cs-off{background:rgba(61,85,96,.3);color:var(--hf-tx3)}
.hf-ccard-name{font-size:.86rem;font-weight:800;margin-bottom:.13rem;color:var(--hf-tx)}
.hf-ccard-desc{font-size:.7rem;color:var(--hf-tx2);line-height:1.5;margin-bottom:.7rem}
.hf-pbar{height:3px;background:var(--hf-bg3);border-radius:2px;margin:.55rem 0;overflow:hidden}
.hf-pfill{height:100%;background:var(--hf-lime);border-radius:2px}
.hf-cmeta{display:grid;grid-template-columns:1fr 1fr;gap:.28rem .55rem;padding-top:.7rem;border-top:1px solid var(--hf-ln)}
.hf-cm-l{font-size:.59rem;color:var(--hf-tx3);text-transform:uppercase;letter-spacing:.05em;margin-bottom:.05rem}
.hf-cm-v{font-family:'DM Mono',monospace;font-size:.68rem;color:var(--hf-tx)}
.hf-ccard-acts{margin-top:.7rem;padding-top:.7rem;border-top:1px solid var(--hf-ln);display:flex;gap:.32rem;flex-wrap:wrap}
.hf-cilist{display:flex;flex-direction:column;gap:.52rem}
.hf-ciitem{display:flex;align-items:center;gap:.85rem;background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;padding:.85rem 1.05rem;transition:border-color .15s}
.hf-ciitem.done{border-color:rgba(127,255,106,.22)}
.hf-ci-emo{font-size:1.65rem;flex-shrink:0}
.hf-ci-info{flex:1}
.hf-ci-name{font-size:.85rem;font-weight:700;margin-bottom:.11rem;color:var(--hf-tx)}
.hf-ci-streak{font-size:.66rem;color:var(--hf-amber);margin-bottom:.05rem}
.hf-ci-pts{font-size:.62rem;color:var(--hf-tx3)}
.hf-ci-act{flex-shrink:0}
.hf-rgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(235px,1fr));gap:.72rem}
.hf-rcard{background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;padding:.95rem;position:relative;overflow:hidden;transition:border-color .15s}
.hf-rcard.earned{border-color:rgba(127,255,106,.28)}
.hf-rcard.earned::after{content:'';position:absolute;top:0;right:0;width:50px;height:50px;background:radial-gradient(circle at top right,rgba(127,255,106,.12),transparent 70%)}
.hf-rcard-emo{font-size:1.45rem;margin-bottom:.28rem}
.hf-rcard-name{font-size:.84rem;font-weight:800;margin-bottom:.11rem;color:var(--hf-tx)}
.hf-rcard-desc{font-size:.69rem;color:var(--hf-tx2);line-height:1.5;margin-bottom:.55rem}
.hf-rtags{display:flex;gap:.28rem;flex-wrap:wrap;align-items:center}
.hf-rtag{font-size:.59rem;font-weight:600;padding:.12rem .36rem;border-radius:4px;background:var(--hf-bg3);color:var(--hf-tx2)}
.hf-rtag-bonus{background:rgba(255,179,71,.07);color:var(--hf-amber)}
.hf-rtag-earned{background:rgba(127,255,106,.07);color:var(--hf-lime)}
.hf-rdel{position:absolute;top:.58rem;right:.58rem;z-index:2}
.hf-tbadge{display:inline-block;font-size:.54rem;font-weight:700;padding:.08rem .33rem;border-radius:4px;vertical-align:middle;letter-spacing:.04em;text-transform:uppercase}
.hf-t-starter{background:rgba(122,144,153,.1);color:var(--hf-tx2)}
.hf-t-building{background:rgba(77,184,255,.1);color:var(--hf-sky)}
.hf-t-onfire{background:rgba(255,179,71,.12);color:var(--hf-amber)}
.hf-t-unstoppable{background:rgba(255,120,71,.12);color:#ff7847}
.hf-t-legend{background:rgba(179,136,255,.12);color:var(--hf-purple)}
.hf-t-mythic{background:rgba(127,255,106,.12);color:var(--hf-lime);animation:hfmpulse 2s ease-in-out infinite}
@keyframes hfmpulse{0%,100%{box-shadow:none}50%{box-shadow:0 0 6px rgba(127,255,106,.4)}}
.hf-pts-base{font-size:.58rem;color:var(--hf-tx3)}
.hf-ttbl{width:100%;border-collapse:collapse;font-size:.73rem}
.hf-ttbl th{text-align:left;padding:.4rem .62rem;color:var(--hf-tx3);font-size:.59rem;text-transform:uppercase;letter-spacing:.07em;border-bottom:1px solid var(--hf-ln)}
.hf-ttbl td{padding:.46rem .62rem;border-bottom:1px solid var(--hf-ln);color:var(--hf-tx)}
.hf-ttbl tr:last-child td{border-bottom:none}
.hf-empty{text-align:center;padding:1.75rem 1rem;color:var(--hf-tx3);border:1px dashed var(--hf-ln);border-radius:11px;font-size:.8rem}
.hf-first-run{background:var(--hf-bg2);border:1px solid rgba(127,255,106,.18);border-radius:11px;padding:2.2rem 1.5rem;text-align:center;position:relative;overflow:hidden}
.hf-fr-glow{position:absolute;top:-50px;left:50%;transform:translateX(-50%);width:260px;height:150px;background:radial-gradient(ellipse,rgba(127,255,106,.07),transparent 70%);pointer-events:none}
.hf-fr-in{position:relative;z-index:1;max-width:360px;margin:0 auto}
.hf-fr-ico{display:inline-block;font-size:1.8rem;background:rgba(127,255,106,.08);border:1px solid rgba(127,255,106,.18);border-radius:11px;width:50px;height:50px;line-height:50px;margin-bottom:.85rem;color:var(--hf-lime)}
.hf-fr-title{font-size:1.15rem;font-weight:800;letter-spacing:-.03em;margin-bottom:.32rem;color:var(--hf-tx)}
.hf-fr-sub{font-size:.78rem;color:var(--hf-tx2);line-height:1.65;margin-bottom:1.15rem}
.hf-mwrap{position:fixed;inset:0;background:rgba(0,0,0,.78);backdrop-filter:blur(7px);z-index:2000;display:none;align-items:center;justify-content:center;padding:1rem}
.hf-mwrap.on{display:flex}
.hf-modal{background:var(--hf-bg2);border:1px solid var(--hf-ln2);border-radius:11px;width:100%;max-width:460px;max-height:90vh;overflow-y:auto}
.hf-mhdr{display:flex;align-items:center;justify-content:space-between;padding:1.1rem 1.1rem 0}
.hf-mhdr h3{font-size:.9rem;font-weight:800;letter-spacing:-.02em;color:var(--hf-tx)}
.hf-mclose{background:none;border:none;color:var(--hf-tx2);font-size:.83rem;cursor:pointer;padding:.2rem;transition:.12s}
.hf-mclose:hover{color:var(--hf-rose)}
.hf-mbody{padding:.95rem 1.1rem}
.hf-mfoot{padding:0 1.1rem 1.1rem;display:flex;justify-content:flex-end;gap:.48rem}
.hf-fg{margin-bottom:.75rem}
.hf-fg label{display:block;font-size:.63rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;color:var(--hf-tx3);margin-bottom:.26rem}
.hf-fg input,.hf-fg select,.hf-fg textarea{background:var(--hf-bg3);border:1px solid var(--hf-ln2);border-radius:8px;color:var(--hf-tx);font-family:'DM Mono',monospace;font-size:.78rem;padding:.52rem .76rem;width:100%;outline:none;transition:border-color .15s;-webkit-appearance:none}
.hf-fg input:focus,.hf-fg select:focus,.hf-fg textarea:focus{border-color:var(--hf-lime)}
.hf-fg input::placeholder,.hf-fg textarea::placeholder{color:var(--hf-tx3)}
.hf-fg select option{background:var(--hf-bg3)}
.hf-fg textarea{resize:vertical}
.hf-frow{display:grid;grid-template-columns:1fr 1fr;gap:.62rem;margin-bottom:.75rem}
.hf-dpick label{display:block;font-size:.63rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;color:var(--hf-tx3);margin-bottom:.23rem}
.hf-drow{display:flex;gap:.26rem;margin-top:.28rem}
.hf-dbtn{width:28px;height:28px;border-radius:50%;border:1px solid var(--hf-ln2);background:var(--hf-bg3);color:var(--hf-tx2);font-family:'DM Mono',monospace;font-size:.62rem;cursor:pointer;transition:.12s}
.hf-dbtn.on{background:var(--hf-lime);color:#080c0e;border-color:var(--hf-lime)}
.hf-tier-preview{background:var(--hf-bg3);border:1px solid var(--hf-ln);border-radius:8px;padding:.65rem;margin-bottom:.75rem}
.hf-tp-label{font-size:.6rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;color:var(--hf-tx3);margin-bottom:.52rem}
.hf-tp-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:.3rem}
.hf-tp-cell{background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:6px;padding:.38rem .42rem;text-align:center}
.hf-tp-days{font-size:.55rem;color:var(--hf-tx3);font-family:'DM Mono',monospace;margin-bottom:.18rem}
.hf-tp-pts{font-size:.85rem;font-weight:800;letter-spacing:-.03em;color:var(--hf-lime)}
.hf-tp-mult{font-size:.52rem;color:var(--hf-tx3);font-family:'DM Mono',monospace;margin-top:.06rem}
.hf-toast{position:fixed;bottom:1.4rem;right:1.4rem;z-index:9000;background:var(--hf-bg2);border:1px solid var(--hf-ln2);border-radius:8px;padding:.68rem .9rem;font-size:.76rem;font-weight:600;font-family:'Bricolage Grotesque',sans-serif;box-shadow:0 8px 28px rgba(0,0,0,.5);max-width:270px;display:none}
.hf-toast.show{display:block}
.hf-toast.ok{border-left:3px solid var(--hf-lime)}
.hf-toast.er{border-left:3px solid var(--hf-rose)}
.hf-toast.in{border-left:3px solid var(--hf-sky)}

/* LOTTO */
#lotto{position:relative;overflow-y:auto;background:var(--bg)}
#lotto-inner{position:relative;z-index:1;padding:0 16px 80px;max-width:1000px;margin:0 auto}
.lo-header{display:flex;align-items:center;justify-content:space-between;padding:52px 0 20px;border-bottom:1px solid var(--border);margin-bottom:24px;flex-wrap:wrap;gap:12px}
.lo-back{font-size:11px;color:var(--accent);font-weight:700;letter-spacing:.12em;text-transform:uppercase;font-family:'DM Mono',monospace;cursor:pointer;padding:6px 0}
.lo-logo-tag{font-family:'DM Mono',monospace;font-size:10px;color:var(--accent);letter-spacing:4px;opacity:.7}
.lo-logo-title{font-size:32px;font-weight:900;letter-spacing:-1px;color:var(--text);line-height:1}
.lo-logo-title span{color:var(--accent)}
.lo-status-bar{display:flex;flex-direction:column;align-items:flex-end;gap:6px}
.lo-status-pill{display:flex;align-items:center;gap:8px;background:var(--surface);border:1px solid var(--border);padding:6px 12px;border-radius:8px;font-family:'DM Mono',monospace;font-size:10px;color:var(--muted)}
.lo-pulse{width:8px;height:8px;border-radius:50%;background:#a8ff3e;animation:loBlink 1.4s ease-in-out infinite;flex-shrink:0}
.lo-pulse.red{background:var(--danger)}
@keyframes loBlink{0%,100%{opacity:1}50%{opacity:.2}}
.lo-btn{padding:11px 22px;border:none;cursor:pointer;font-family:'Syne',sans-serif;font-size:13px;font-weight:700;letter-spacing:2px;text-transform:uppercase;border-radius:8px;transition:all .2s;white-space:nowrap}
.lo-btn-secondary{background:transparent;color:#ff6b35;border:1px solid #ff6b35}
.lo-btn-secondary:hover{background:#ff6b35;color:#000}
.lo-add-panel{background:var(--surface);border:1px solid var(--border);padding:18px 20px;margin-bottom:20px;border-radius:14px}
.lo-add-panel h3{font-family:'DM Mono',monospace;font-size:10px;letter-spacing:4px;color:#ff6b35;margin-bottom:14px}
.lo-num-inputs{display:flex;gap:8px;flex-wrap:wrap;align-items:center}
.lo-num-inputs input{width:54px;text-align:center;background:var(--bg);border:1.5px solid var(--border);color:var(--accent);font-family:'DM Mono',monospace;font-size:17px;font-weight:700;padding:9px 4px;border-radius:8px;outline:none}
.lo-num-inputs input:focus{border-color:var(--accent)}
.lo-date-input{background:var(--bg);border:1.5px solid var(--border);color:var(--text);font-family:'DM Mono',monospace;font-size:13px;padding:9px 12px;border-radius:8px;outline:none;width:auto}
.lo-date-input:focus{border-color:var(--accent)}
.lo-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:20px}
@media(max-width:600px){.lo-stats{grid-template-columns:repeat(2,1fr)}}
.lo-stat{background:var(--surface);border:1px solid var(--border);padding:16px;border-radius:12px}
.lo-stat-lbl{font-family:'DM Mono',monospace;font-size:9px;letter-spacing:3px;color:var(--muted);margin-bottom:6px;text-transform:uppercase}
.lo-stat-val{font-size:28px;font-weight:900;line-height:1}
.lo-stat-val.c1{color:var(--accent)}.lo-stat-val.c2{color:#ff6b35}.lo-stat-val.c3{color:#a8ff3e}.lo-stat-val.c4{color:#ffd700}
.lo-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:20px}
@media(max-width:700px){.lo-grid{grid-template-columns:1fr}}
.lo-card{background:var(--surface);border:1px solid var(--border);padding:20px;border-radius:14px;position:relative;overflow:hidden}
.lo-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px}
.lo-card.lo-cyan::before{background:var(--accent)}.lo-card.lo-orange::before{background:#ff6b35}.lo-card.lo-green::before{background:#a8ff3e}.lo-card.lo-gold::before{background:#ffd700}
.lo-card-lbl{font-family:'DM Mono',monospace;font-size:9px;letter-spacing:4px;color:var(--muted);margin-bottom:12px;text-transform:uppercase}
.lo-card h2{font-size:16px;font-weight:800;color:var(--text);margin-bottom:16px;letter-spacing:.5px}
.lo-pred-row{background:var(--bg);border:1px solid var(--border);padding:12px 14px;display:flex;align-items:center;gap:12px;border-radius:10px;margin-bottom:10px}
.lo-pred-row:hover{border-color:var(--accent)}
.lo-pred-rank{font-family:'DM Mono',monospace;font-size:10px;color:var(--muted);min-width:40px;flex-shrink:0}
.lo-pred-balls{display:flex;gap:6px;flex-wrap:wrap;flex:1}
.lo-ball{width:34px;height:34px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-family:'DM Mono',monospace;font-size:12px;font-weight:700;border:2px solid;flex-shrink:0}
.lo-ball.cyan{background:rgba(0,229,255,.1);border-color:var(--accent);color:var(--accent)}.lo-ball.orange{background:rgba(255,107,53,.1);border-color:#ff6b35;color:#ff6b35}.lo-ball.green{background:rgba(168,255,62,.1);border-color:#a8ff3e;color:#a8ff3e}.lo-ball.gold{background:rgba(255,215,0,.1);border-color:#ffd700;color:#ffd700}.lo-ball.white{background:rgba(255,255,255,.05);border-color:rgba(255,255,255,.2);color:var(--text)}
.lo-pred-score{margin-left:auto;font-family:'DM Mono',monospace;font-size:10px;color:var(--muted);text-align:right;flex-shrink:0}
.lo-pred-score span{display:block;font-size:15px;font-weight:700;color:#a8ff3e}
.lo-hot-grid{display:grid;grid-template-columns:repeat(7,1fr);gap:6px}
.lo-hot-cell{background:var(--bg);border:1px solid var(--border);padding:8px 4px;text-align:center;border-radius:8px;cursor:default}
.lo-hot-cell:hover{border-color:var(--accent)}
.lo-hot-num{font-family:'DM Mono',monospace;font-size:13px;font-weight:700;color:var(--text);display:block}
.lo-hot-bar{height:3px;background:var(--accent);margin-top:5px;border-radius:1px}
.lo-hot-cnt{font-family:'DM Mono',monospace;font-size:8px;color:var(--muted);display:block;margin-top:3px}
.lo-hot-cell.lhot1 .lo-hot-bar{background:#ffd700}.lo-hot-cell.lhot2 .lo-hot-bar{background:var(--accent)}.lo-hot-cell.lhot3 .lo-hot-bar{background:#ff6b35}
.lo-algo{background:var(--surface);border:1px solid var(--border);padding:16px 20px;margin-bottom:20px;border-radius:14px;display:grid;grid-template-columns:repeat(auto-fit,minmax(175px,1fr));gap:14px}
.lo-algo-tag{font-family:'DM Mono',monospace;font-size:9px;letter-spacing:3px;color:var(--muted)}
.lo-algo-name{font-size:14px;font-weight:700}
.lo-algo-desc{font-size:11px;color:var(--muted);line-height:1.5;font-family:'DM Mono',monospace}
.lo-history-table{width:100%;border-collapse:collapse;font-family:'DM Mono',monospace;font-size:12px}
.lo-history-table th{padding:9px 12px;text-align:left;font-size:9px;letter-spacing:3px;color:var(--muted);border-bottom:1px solid var(--border);text-transform:uppercase}
.lo-history-table td{padding:9px 12px;border-bottom:1px solid var(--border);color:var(--text)}
.lo-history-table tr:hover td{background:var(--accent-bg)}
.lo-mini-ball{display:inline-flex;align-items:center;justify-content:center;width:24px;height:24px;border-radius:50%;background:var(--accent-bg);border:1px solid var(--border);color:var(--accent);font-size:10px;font-weight:700;margin:0 1px}
.lo-del-btn{background:none;border:none;color:var(--muted);cursor:pointer;font-size:14px;padding:2px 6px}
.lo-del-btn:hover{color:var(--danger)}
.lo-empty{padding:32px;text-align:center;font-family:'DM Mono',monospace;font-size:11px;color:var(--muted);letter-spacing:2px}
.lo-loading{display:flex;flex-direction:column;align-items:center;padding:40px;gap:12px}
.lo-spinner{width:36px;height:36px;border-radius:50%;border:2px solid var(--border);border-top-color:var(--accent);animation:loSpin .8s linear infinite}
@keyframes loSpin{to{transform:rotate(360deg)}}
.lo-loading-txt{font-family:'DM Mono',monospace;font-size:11px;letter-spacing:3px;color:var(--muted)}
.lo-chart-wrap{position:relative;height:200px}
#lo-toast{position:fixed;bottom:24px;right:24px;z-index:600;background:var(--surface);border:1px solid var(--border);padding:12px 18px;font-family:'DM Mono',monospace;font-size:12px;letter-spacing:2px;color:#a8ff3e;transform:translateX(200%);transition:transform .3s;max-width:300px;border-radius:10px}
#lo-toast.show{transform:translateX(0)}
#lo-toast.lo-err{color:var(--danger);border-color:var(--danger)}

/* Mobile HF sidebar hide */
@media(max-width:700px){.hf-sb{display:none}.hf-main{padding:1rem}.hf-stats{grid-template-columns:repeat(2,1fr)}}
@media(max-width:479px){
  #chronoluna header{padding:12px 14px 10px}
  .cl-logo-text{font-size:1.05rem}.cl-logo-sub{display:none}
  .cl-header-actions{gap:6px}.cl-icon-btn{width:36px;height:36px;font-size:15px}
  #sb-indicator-label{display:none}.sb-indicator{padding:5px 8px}
  #cl-next-banner{padding:10px 14px;gap:10px}
  #cl-next-banner .banner-days{font-size:1.6rem}
  #cl-carousel-section{padding:14px 0 4px}
  .cl-section-title{padding:0 14px 10px;font-size:.92rem}
  .cl-carousel-track{padding:8px 14px 14px;gap:12px}
  .event-card{min-width:calc(100vw - 44px);max-width:calc(100vw - 44px);padding:14px 13px 12px}
  .countdown-num{font-size:1.3rem}
  #cl-list-section{padding:6px 14px 100px}
  .cl-fab{padding:13px 15px;font-size:.88rem;bottom:20px;right:14px}
  .cl-modal{padding:18px 15px env(safe-area-inset-bottom,22px)}
}
@media(min-width:640px){
  .cl-overlay{align-items:center}
  .cl-modal{border-radius:24px;margin:auto;margin-bottom:24px}
  .event-card{min-width:300px;max-width:300px}
  .cl-carousel-track{padding:10px 26px 18px}
  #cl-list-section{padding:10px 26px 110px}
  .cl-logo-sub{display:block}
  #sb-indicator-label{display:inline}
}
</style>
</head>
<body>
<!-- SETUP -->
<div id="setup" class="screen active">
  <div style="font-size:11px;letter-spacing:.22em;text-transform:uppercase;color:var(--accent);font-weight:700;display:flex;align-items:center;gap:7px">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="16" height="16"><rect x="2" y="2" width="6" height="6" rx="1.5" fill="#8b6340" opacity="0.7"/><rect x="10" y="2" width="6" height="6" rx="1.5" fill="#8b6340" opacity="0.5"/><rect x="2" y="10" width="6" height="6" rx="1.5" fill="#8b6340" opacity="0.5"/><rect x="10" y="10" width="6" height="6" rx="1.5" fill="#8b6340" opacity="0.35"/><path d="M19 5 L19 15 L13 24 Q11.5 27 14 28.5 L28 28.5 Q30.5 27 29 24 L23 15 L23 5 Z" fill="none" stroke="#8b6340" stroke-width="1.6" stroke-linejoin="round"/><path d="M17.5 20 Q20 18 24 21 Q26.5 23 29 24 Q30.5 27 28 28.5 L14 28.5 Q11.5 27 13 24 Z" fill="#8b6340" opacity="0.25"/><line x1="19" y1="9" x2="23" y2="9" stroke="#8b6340" stroke-width="1.4"/></svg>
    Labdeck &middot; Setup
  </div>
  <div><div class="big-title">Your personal<br><span>lab hub.</span></div><p class="sub" style="margin-top:10px">Connect Supabase once — shared by Spendly, ChronoLuna &amp; HabitForge. Credentials stay in your browser.</p></div>
  <div><div class="field-label">Your Name</div><input id="user-name" type="text" placeholder="User" autocomplete="given-name"></div>
  <div><div class="field-label">Supabase URL</div><input id="supabase-url" type="url" placeholder="https://yourproject.supabase.co" autocomplete="off"></div>
  <div><div class="field-label">Supabase Publishable Key</div><input id="supabase-key" type="password" placeholder="sb_publishable_..." autocomplete="off"><p class="sub" style="margin-top:6px">Project Settings &rarr; API &rarr; Publishable key</p></div>
  <div><div class="field-label">Currency Symbol</div><input id="cur-sym" type="text" placeholder="$" maxlength="3" style="width:80px"></div>
  <button class="btn" onclick="initSupabase()">Connect &amp; Start &rarr;</button>
  <div class="help-link" onclick="goGuide()">&#128218; Supabase setup guide</div>
</div>

<!-- DASHBOARD -->
<div id="dashboard" class="screen">
  <div class="dash-header">
    <div class="dash-logo">
      <div class="dash-logo-tag">Labdeck</div>
      <div class="dash-title">Lab<span>deck</span></div>
      <div class="dash-subtitle" id="dash-greeting">Good morning</div>
    </div>
    <div class="dash-actions">
      <div class="ld-icon-btn" onclick="refreshAll()">&#x21BB;</div>
      <div class="ld-icon-btn" onclick="openSpendlySettings()">&#9881;&#65039;</div>
    </div>
  </div>

  <!-- Event banner with points pill -->
  <div class="event-banner hidden" id="event-banner" onclick="go('chronoluna')">
    <div class="evb-left">
      <div class="evb-tag">&#x23F0; Next Up</div>
      <div class="evb-name" id="evb-name">&mdash;</div>
      <div class="evb-sub" id="evb-sub">Tap to view all events &rarr;</div>
      <div class="evb-pts-pill" id="evb-pts-pill" style="display:none">
        <span class="evb-pts-ico">&#11088;</span>
        <span class="evb-pts-val" id="evb-pts-val">0</span>
        <span class="evb-pts-lbl">habit pts</span>
      </div>
    </div>
    <div class="evb-right">
      <div class="evb-days" id="evb-days">&mdash;</div>
      <div class="evb-days-label">days</div>
    </div>
    <div class="evb-arrow">&#x203A;</div>
  </div>

  <div class="dash-summary">
    <div>
      <div class="dash-sum-label" id="dash-sum-label">This month</div>
      <div class="dash-sum-amount"><span id="dash-cur">$</span><span id="dash-total">0.00</span></div>
      <div class="dash-sum-count" id="dash-count">0 transactions</div>
    </div>
    <div class="dash-sum-right">
      <div class="dash-sum-month" id="dash-month-name">&mdash;</div>
      <div class="dash-sum-trend" id="dash-trend">vs last month</div>
    </div>
  </div>

  <div class="dash-charts-label">Spending &middot; tap to detail</div>
  <div class="charts-carousel active" id="charts-carousel" onscroll="onChartCarouselScroll()">
    <div class="carousel-chart-card" onclick="S.filter='all';go('main')">
      <div class="carousel-chart-label">Monthly breakdown <span>Detail &rarr;</span></div>
      <div id="dash-pie-empty" class="chart-empty-small">Log transactions to see breakdown</div>
      <div id="dash-pie-wrap" class="pie-wrap" style="display:none"><canvas id="dash-pie-canvas" width="100" height="100" style="width:100px;height:100px;flex-shrink:0"></canvas><div class="dash-legend" id="dash-legend"></div></div>
    </div>
    <div class="carousel-chart-card" onclick="S.filter='all';go('main')">
      <div class="carousel-chart-label">Annual spending <span>Detail &rarr;</span></div>
      <div id="dash-line-empty" class="chart-empty-small">No data yet for this year</div>
      <div class="line-chart-wrap" id="dash-line-wrap" style="display:none"><canvas id="dash-line-canvas" style="width:100%;height:130px"></canvas></div>
    </div>
  </div>
  <div class="cdots active" id="chart-cdots" style="display:flex;margin-bottom:16px">
    <div class="cdot on" id="cdot-0"></div><div class="cdot" id="cdot-1"></div>
  </div>
  <div class="charts-grid" id="charts-grid" style="margin-bottom:16px">
    <div class="chart-panel" onclick="S.filter='all';go('main')">
      <div class="chart-panel-label">Monthly breakdown <span>Detail &rarr;</span></div>
      <div id="dash-pie-empty-t" class="chart-empty-small">Log transactions to see breakdown</div>
      <div id="dash-pie-wrap-t" class="pie-wrap" style="display:none"><canvas id="dash-pie-canvas-t" width="110" height="110" style="width:110px;height:110px;flex-shrink:0"></canvas><div class="dash-legend" id="dash-legend-t"></div></div>
    </div>
    <div class="chart-panel" onclick="S.filter='all';go('main')">
      <div class="chart-panel-label">Annual spending <span>Detail &rarr;</span></div>
      <div id="dash-line-empty-t" class="chart-empty-small">No data yet for this year</div>
      <div class="line-chart-wrap" id="dash-line-wrap-t" style="display:none"><canvas id="dash-line-canvas-t" style="width:100%;height:150px"></canvas></div>
    </div>
  </div>
  <div class="apps-section">
    <div class="apps-label">My Apps</div>
    <div class="apps-grid" id="apps-grid"></div>
  </div>
  <div class="dash-bottom-space"></div>
</div>

<!-- SPENDLY -->
<div id="main" class="screen">
  <div class="sp-header">
    <div>
      <div style="font-size:11px;color:var(--accent);font-weight:700;letter-spacing:.12em;text-transform:uppercase;font-family:'DM Mono',monospace;cursor:pointer;margin-bottom:2px" onclick="go('dashboard')">&larr; Dashboard</div>
      <div class="sp-greeting" id="sp-greeting">Transactions</div>
    </div>
    <div class="sp-header-btns">
      <div class="sp-icon-btn" id="sp-refresh-btn" onclick="fetchTxns()">&#x21BB;</div>
      <div class="sp-icon-btn" onclick="openSpendlySettings()">&#9881;&#65039;</div>
    </div>
  </div>
  <div class="sync-bar"><div class="sync-dot" id="sync-dot"></div><span id="sync-label">Ready</span></div>
  <div class="month-card" onclick="openMonthPicker()">
    <div style="display:flex;justify-content:space-between;margin-bottom:6px"><div class="month-lbl" id="mlbl">This month</div><div style="font-size:11px;color:rgba(250,247,242,.5)">tap to browse &rsaquo;</div></div>
    <div class="month-total"><span class="month-cur" id="cur-disp">$</span><span id="total">0.00</span></div>
    <div class="month-count" id="txn-count">0 transactions</div>
  </div>
  <div class="charts-carousel active" id="sp-charts-carousel" onscroll="onSpChartScroll()" style="margin:0 0 4px">
    <div class="carousel-chart-card" style="cursor:default">
      <div class="carousel-chart-label">Monthly breakdown</div>
      <div class="chart-empty-small" id="sp-pie-empty">Log your first transaction to see the breakdown</div>
      <div class="pie-wrap" id="sp-pie-wrap" style="display:none"><canvas id="sp-pie-canvas" width="120" height="120" style="width:120px;height:120px;flex-shrink:0"></canvas><div class="legend" id="sp-legend"></div></div>
    </div>
    <div class="carousel-chart-card" style="cursor:default">
      <div class="carousel-chart-label">Annual spending</div>
      <div class="chart-empty-small" id="sp-line-empty">No data yet for this year</div>
      <div class="line-chart-wrap" id="sp-line-wrap" style="display:none"><canvas id="sp-line-canvas" style="width:100%;height:130px"></canvas></div>
    </div>
  </div>
  <div class="cdots" id="sp-cdots" style="display:flex;margin-bottom:12px"><div class="cdot on"></div><div class="cdot"></div></div>
  <div class="section-hdr">Transactions</div>
  <div class="filter-row" id="filter-row"></div>
  <div class="txn-list" id="txn-list"></div>
  <button class="sp-fab" onclick="openAddTxn()">+</button>
</div>

<!-- GUIDE -->
<div id="guide" class="screen">
  <div class="gback" onclick="go('setup')">&larr; Back to setup</div>
  <div class="gtitle">Supabase Setup</div>
  <div class="gstep"><div class="snum">Step 01</div><div class="stitle">supabase.com &rarr; New project</div><div class="sdesc">Name it "Labdeck" and set a strong database password.</div></div>
  <div class="gstep"><div class="snum">Step 02 &mdash; Spendly (expenses)</div><div class="stitle">SQL Editor &rarr; Run:</div><div class="code-box">CREATE TABLE expenses (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), name TEXT NOT NULL, amount DECIMAL(10,2) NOT NULL, category TEXT NOT NULL, date TIMESTAMP WITH TIME ZONE DEFAULT NOW());<br>ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;<br>CREATE POLICY "public access" ON expenses FOR ALL USING (true);</div></div>
  <div class="gstep"><div class="snum">Step 03 &mdash; ChronoLuna (events)</div><div class="stitle">SQL Editor &rarr; Run:</div><div class="code-box">CREATE TABLE events (id TEXT PRIMARY KEY, name TEXT, date TEXT, category TEXT, repeat TEXT, cal_type TEXT, lunar_meta TEXT, notes TEXT, notifs TEXT, color TEXT, updated_at TEXT);<br>ALTER TABLE events ENABLE ROW LEVEL SECURITY;<br>CREATE POLICY "public access" ON events FOR ALL USING (true);</div></div>
  <div class="gstep"><div class="snum">Step 04 &mdash; HabitForge tables</div><div class="stitle">SQL Editor &rarr; Run:</div><div class="code-box">CREATE EXTENSION IF NOT EXISTS "uuid-ossp";<br>CREATE TABLE IF NOT EXISTS hf_settings(id TEXT PRIMARY KEY DEFAULT 'user', total_points INTEGER NOT NULL DEFAULT 0, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW());<br>INSERT INTO hf_settings(id) VALUES('user') ON CONFLICT DO NOTHING;<br>CREATE TABLE IF NOT EXISTS hf_campaigns(id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), name TEXT NOT NULL, description TEXT DEFAULT '', emoji TEXT DEFAULT '&#128204;', start_date DATE NOT NULL DEFAULT CURRENT_DATE, end_date DATE, points_per_checkin INTEGER NOT NULL DEFAULT 10, frequency TEXT NOT NULL DEFAULT 'daily', custom_days INTEGER[], is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW());<br>CREATE TABLE IF NOT EXISTS hf_checkins(id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), campaign_id UUID NOT NULL REFERENCES hf_campaigns(id) ON DELETE CASCADE, checked_date DATE NOT NULL DEFAULT CURRENT_DATE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), UNIQUE(campaign_id, checked_date));<br>CREATE TABLE IF NOT EXISTS hf_rewards(id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), name TEXT NOT NULL, description TEXT DEFAULT '', emoji TEXT DEFAULT '&#127942;', campaign_id UUID REFERENCES hf_campaigns(id) ON DELETE SET NULL, trigger_type TEXT NOT NULL DEFAULT 'streak', trigger_value INTEGER NOT NULL DEFAULT 7, bonus_points INTEGER NOT NULL DEFAULT 50, is_repeatable BOOLEAN NOT NULL DEFAULT FALSE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW());<br>CREATE TABLE IF NOT EXISTS hf_earned(id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), reward_id UUID NOT NULL REFERENCES hf_rewards(id) ON DELETE CASCADE, earned_at TIMESTAMPTZ NOT NULL DEFAULT NOW());<br>ALTER TABLE hf_settings DISABLE ROW LEVEL SECURITY;<br>ALTER TABLE hf_campaigns DISABLE ROW LEVEL SECURITY;<br>ALTER TABLE hf_checkins DISABLE ROW LEVEL SECURITY;<br>ALTER TABLE hf_rewards DISABLE ROW LEVEL SECURITY;<br>ALTER TABLE hf_earned DISABLE ROW LEVEL SECURITY;</div></div>
  <div class="gstep"><div class="snum">Step 05 &mdash; Get credentials</div><div class="stitle">Project Settings &rarr; API</div><div class="sdesc">Copy your URL and publishable key. One key connects all Labdeck apps.</div></div>
  <button class="btn" onclick="go('setup')" style="margin-top:4px">&larr; Back to setup</button>
</div>

<!-- CHRONOLUNA -->
<div id="chronoluna" class="screen">
  <header>
    <div style="cursor:pointer" onclick="go('dashboard')"><span style="font-size:11px;color:var(--accent);font-weight:700;letter-spacing:.12em;text-transform:uppercase;font-family:'DM Mono',monospace">&larr; Dashboard</span></div>
    <div style="display:flex;align-items:center;gap:6px;position:absolute;left:50%;transform:translateX(-50%)">
      <span style="font-size:24px">&#128302;</span>
      <div><span class="cl-logo-text">ChronoLuna</span><span class="cl-logo-sub">Event Countdown</span></div>
    </div>
    <div class="cl-header-actions">
      <div class="sb-indicator local" id="sb-indicator"><span class="dot"></span><span id="sb-indicator-label">Local</span></div>
      <button class="cl-icon-btn" id="cl-theme-btn">&#127769;</button>
      <button class="cl-icon-btn" id="cl-settings-btn">&#9881;&#65039;</button>
    </div>
  </header>
  <div id="cl-next-banner" class="hidden">
    <div><span class="banner-label">Next Up</span><span class="banner-name" id="banner-name">&mdash;</span></div>
    <div class="banner-count"><span class="banner-days" id="banner-days">0</span><span style="font-size:.7rem;opacity:.8"> days</span></div>
  </div>
  <div id="cl-carousel-section">
    <div class="cl-section-title">&#10022; Upcoming Events</div>
    <div style="overflow:hidden"><div class="cl-carousel-track" id="carousel-track"></div></div>
  </div>
  <div id="cl-list-section">
    <div class="cl-section-title">&#10022; All Events</div>
    <div class="filter-tabs" id="filter-tabs">
      <button class="filter-tab active" data-filter="all">All</button>
      <button class="filter-tab" data-filter="&#127874;">&#127874; Birthday</button>
      <button class="filter-tab" data-filter="&#128141;">&#128141; Anniversary</button>
      <button class="filter-tab" data-filter="&#128302;">&#128302; Festival</button>
      <button class="filter-tab" data-filter="&#127919;">&#127919; Deadline</button>
      <button class="filter-tab" data-filter="&#9992;&#65039;">&#9992;&#65039; Travel</button>
      <button class="filter-tab" data-filter="&#11088;">&#11088; Other</button>
    </div>
    <div id="event-list"></div>
  </div>
  <button class="cl-fab" id="add-btn">&#65291; Add Event</button>
</div>

<!-- HABITFORGE -->
<div id="habitforge" class="screen">
  <div class="hf-screen">
    <aside class="hf-sb">
      <button class="hf-back-btn" onclick="go('dashboard')">&larr; Dashboard</button>
      <div class="hf-sb-top"><div class="hf-brand-box">H</div>HabitForge</div>
      <nav class="hf-nav">
        <button class="hf-nb on" data-hv="dashboard" onclick="hfNav('dashboard')">&#9672; Dashboard</button>
        <button class="hf-nb" data-hv="campaigns" onclick="hfNav('campaigns')">&#9677; Campaigns</button>
        <button class="hf-nb" data-hv="checkin" onclick="hfNav('checkin')">&#9678; Daily Check-in</button>
        <button class="hf-nb" data-hv="rewards" onclick="hfNav('rewards')">&#11041; Rewards</button>
      </nav>
      <div class="hf-sb-foot"><div class="hf-sb-pts"><strong id="hf-sb-pts">0</strong>total pts</div></div>
    </aside>
    <main class="hf-main">
      <section id="hf-view-dashboard" class="hf-view on">
        <div class="hf-vhdr"><h2>Dashboard</h2><div class="hf-vhdr-r"><div class="hf-datetag" id="hf-dash-date"></div><button class="hf-btn-green" onclick="hfNewCampaign()">+ New Campaign</button></div></div>
        <div class="hf-stats">
          <div class="hf-sc"><div class="hf-sc-v" id="hf-st-active">&ndash;</div><div class="hf-sc-l">Active Campaigns</div></div>
          <div class="hf-sc hi"><div class="hf-sc-v" id="hf-st-streak">&ndash;</div><div class="hf-sc-l">Best Streak &#128293;</div></div>
          <div class="hf-sc"><div class="hf-sc-v" id="hf-st-pts">&ndash;</div><div class="hf-sc-l">Total Points</div></div>
          <div class="hf-sc"><div class="hf-sc-v" id="hf-st-ci">&ndash;</div><div class="hf-sc-l">All Check-ins</div></div>
        </div>
        <div class="hf-slabel">Today's Habits</div>
        <div id="hf-dash-habits" class="hf-hgrid"></div>
        <div class="hf-slabel">Recent Activity</div>
        <div id="hf-dash-feed" class="hf-feed"></div>
      </section>
      <section id="hf-view-campaigns" class="hf-view">
        <div class="hf-vhdr"><h2>Campaigns</h2><button class="hf-btn-green" onclick="hfNewCampaign()">+ New Campaign</button></div>
        <div id="hf-camp-grid" class="hf-cgrid"></div>
      </section>
      <section id="hf-view-checkin" class="hf-view">
        <div class="hf-vhdr"><h2>Daily Check-in</h2><div class="hf-datetag" id="hf-ci-date"></div></div>
        <p style="color:var(--hf-tx2);font-size:.78rem;margin-bottom:1rem;line-height:1.65">Mark habits completed today. One check-in per habit per day.</p>
        <div id="hf-ci-list" class="hf-cilist"></div>
      </section>
      <section id="hf-view-rewards" class="hf-view">
        <div class="hf-vhdr"><h2>Rewards</h2><button class="hf-btn-green" onclick="hfOpenModal('hf-reward-modal')">+ New Reward</button></div>
        <div class="hf-slabel">Streak Point Multipliers</div>
        <div style="background:var(--hf-bg2);border:1px solid var(--hf-ln);border-radius:11px;overflow:hidden;margin-bottom:1.4rem">
          <table class="hf-ttbl">
            <thead><tr><th>Streak Days</th><th>Tier</th><th>Multiplier</th><th>Example (10 base pts)</th></tr></thead>
            <tbody>
              <tr><td>1&ndash;3</td><td><span class="hf-tbadge hf-t-starter">Starter</span></td><td>&times;1.0</td><td>10 pts/day</td></tr>
              <tr><td>4&ndash;7</td><td><span class="hf-tbadge hf-t-building">Building</span></td><td>&times;1.5</td><td>15 pts/day</td></tr>
              <tr><td>8&ndash;14</td><td><span class="hf-tbadge hf-t-onfire">On Fire</span></td><td>&times;2.0</td><td>20 pts/day</td></tr>
              <tr><td>15&ndash;29</td><td><span class="hf-tbadge hf-t-unstoppable">Unstoppable</span></td><td>&times;3.0</td><td>30 pts/day</td></tr>
              <tr><td>30&ndash;59</td><td><span class="hf-tbadge hf-t-legend">Legend</span></td><td>&times;4.0</td><td>40 pts/day</td></tr>
              <tr><td>60+</td><td><span class="hf-tbadge hf-t-mythic">Mythic &#10024;</span></td><td>&times;5.0</td><td>50 pts/day</td></tr>
            </tbody>
          </table>
        </div>
        <div class="hf-slabel">Milestone Rewards</div>
        <div id="hf-reward-grid" class="hf-rgrid"></div>
      </section>
    </main>
  </div>
</div>

<!-- LOTTO -->
<div id="lotto" class="screen" style="overflow-y:auto;background:var(--bg)">
<div id="lotto-inner">
  <div class="lo-header">
    <div>
      <div class="lo-back" onclick="go('dashboard')">&larr; Dashboard</div>
      <div class="lo-logo-tag">// PREDICTIVE ANALYTICS ENGINE v2.0</div>
      <div class="lo-logo-title">LOTTO <span>ORACLE</span></div>
    </div>
    <div class="lo-status-bar">
      <div class="lo-status-pill"><span class="lo-pulse red" id="lo-dbPulse"></span><span id="lo-dbStatus">LOADING&hellip;</span></div>
      <div class="lo-status-pill"><span id="lo-lastUpdate">&mdash;</span></div>
    </div>
  </div>
  <div class="lo-add-panel">
    <h3>// LOG NEW DRAW</h3>
    <div class="lo-num-inputs">
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N1" style="width:54px"/>
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N2" style="width:54px"/>
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N3" style="width:54px"/>
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N4" style="width:54px"/>
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N5" style="width:54px"/>
      <input type="number" class="lo-draw-num" min="1" max="49" placeholder="N6" style="width:54px"/>
      <input type="date" class="lo-date-input" id="lo-drawDate"/>
      <button class="lo-btn lo-btn-secondary" onclick="loAddDraw()">+ LOG DRAW</button>
    </div>
  </div>
  <div class="lo-stats">
    <div class="lo-stat"><div class="lo-stat-lbl">TOTAL DRAWS</div><div class="lo-stat-val c1" id="lo-statDraws">&mdash;</div></div>
    <div class="lo-stat"><div class="lo-stat-lbl">HOTTEST NUMBER</div><div class="lo-stat-val c2" id="lo-statHot">&mdash;</div></div>
    <div class="lo-stat"><div class="lo-stat-lbl">COLDEST NUMBER</div><div class="lo-stat-val c3" id="lo-statCold">&mdash;</div></div>
    <div class="lo-stat"><div class="lo-stat-lbl">NUMBERS TRACKED</div><div class="lo-stat-val c4" id="lo-statNumbers">49</div></div>
  </div>
  <div class="lo-grid">
    <div class="lo-card lo-gold" style="grid-row:span 2">
      <div class="lo-card-lbl">// AI PREDICTION ENGINE</div><h2>NEXT DRAW PREDICTIONS</h2>
      <div id="lo-predictionSets"><div class="lo-empty">AWAITING DATA FEED&hellip;</div></div>
    </div>
    <div class="lo-card lo-cyan"><div class="lo-card-lbl">// FREQUENCY ANALYSIS</div><h2>HOT NUMBER HEATMAP</h2><div id="lo-hotGrid" class="lo-hot-grid"></div></div>
    <div class="lo-card lo-orange"><div class="lo-card-lbl">// TOP 15 FREQUENCY</div><h2>DRAW DISTRIBUTION</h2><div class="lo-chart-wrap"><canvas id="lo-freqChart"></canvas></div></div>
  </div>
  <div class="lo-algo">
    <div><span class="lo-algo-tag">// SET A</span><div class="lo-algo-name" style="color:var(--accent)">FREQUENCY BOOST</div><div class="lo-algo-desc">Top 6 historically most drawn numbers.</div></div>
    <div><span class="lo-algo-tag">// SET B</span><div class="lo-algo-name" style="color:#ff6b35">DUE NUMBER THEORY</div><div class="lo-algo-desc">Numbers overdue based on expected vs actual gap.</div></div>
    <div><span class="lo-algo-tag">// SET C</span><div class="lo-algo-name" style="color:#a8ff3e">PAIR CORRELATION</div><div class="lo-algo-desc">Numbers that appear most often together.</div></div>
    <div><span class="lo-algo-tag">// SET D</span><div class="lo-algo-name" style="color:#ffd700">WEIGHTED HYBRID</div><div class="lo-algo-desc">Blends frequency, recency, and pair data.</div></div>
    <div><span class="lo-algo-tag">// SET E</span><div class="lo-algo-name" style="color:#c77dff">COLD SURGE</div><div class="lo-algo-desc">Cold numbers with recent uptick &mdash; reversal.</div></div>
  </div>
  <div class="lo-card lo-green" style="margin-bottom:20px">
    <div class="lo-card-lbl">// DRAW HISTORY LOG</div><h2>PAST DRAWS</h2>
    <div id="lo-historyWrap"><div class="lo-empty">NO DRAWS LOGGED YET</div></div>
  </div>
</div>
</div>
<div id="lo-toast"></div>

<!-- SPENDLY MODALS -->
<div class="sp-overlay" id="sp-overlay">
  <div class="sp-modal">
    <div class="sp-handle"></div>
    <div class="sp-modal-title" id="sp-modal-title">New transaction</div>
    <label class="sp-modal-lbl">Amount</label>
    <div class="amt-wrap"><span class="amt-prefix" id="mcur">$</span><input id="sp-amt-input" type="number" inputmode="decimal" placeholder="0.00" min="0" step="0.01"></div>
    <label class="sp-modal-lbl">Description</label>
    <input id="txn-name" type="text" placeholder="e.g. Coffee &amp; croissant" style="margin-bottom:14px">
    <label class="sp-modal-lbl">Category</label>
    <div class="cat-grid-modal" id="cat-row"></div>
    <button class="btn" id="sp-modal-btn" onclick="submitTxn()">Log transaction &rarr;</button>
    <div style="height:8px"></div>
    <div class="help-link" onclick="closeSpModal()">Cancel</div>
  </div>
</div>
<div class="sp-overlay" id="sp-month-overlay">
  <div class="sp-modal" style="max-height:70dvh;overflow-y:auto">
    <div class="sp-handle"></div>
    <div class="sp-modal-title">Browse months</div>
    <div id="month-picker-list" style="display:flex;flex-direction:column;gap:8px"></div>
    <div style="height:8px"></div>
    <div class="help-link" onclick="closeMonthPicker()">Close</div>
  </div>
</div>
<div class="sp-overlay" id="sp-settings-overlay">
  <div class="sp-modal" style="max-height:85dvh;overflow-y:auto">
    <div class="sp-handle"></div>
    <div class="sp-modal-title">Settings</div>
    <div class="sp-settings-row"><div><div class="sp-settings-label">Dark Mode</div></div><div class="sp-toggle-switch" id="sp-dark-toggle"></div></div>
    <div class="sp-settings-row"><div><div class="sp-settings-label">Browser Notifications</div><div class="sp-settings-sub">Get reminded about spending</div></div><div class="sp-toggle-switch" id="sp-notif-toggle"></div></div>
    <div class="sp-settings-section-lbl">Data</div>
    <button class="sp-export-btn" id="sp-export-csv-btn">&#128228; Export Transactions (CSV)</button>
    <button class="sp-export-btn" id="sp-export-json-btn">&#128203; Export Transactions (JSON)</button>
    <div class="sp-settings-section-lbl">Supabase Connection</div>
    <div class="sp-db-card">
      <div class="sp-db-status" id="sp-db-status-lbl">Not connected</div>
      <div class="sp-db-url" id="sp-db-url-lbl"></div>
      <div style="font-size:11px;color:var(--muted);margin-bottom:10px;font-family:'DM Mono',monospace;font-weight:300;line-height:1.5" id="sp-db-hint">&#128241; Data saved in this browser only.</div>
      <button class="sp-db-btn" id="sp-db-reconf-btn">&#9881;&#65039; Edit Connection</button>
      <button class="sp-db-btn" id="sp-db-test-btn" style="display:none">&#128269; Test Spendly DB</button>
      <button class="sp-db-btn" id="sp-db-test-hf-btn" style="display:none">&#129514; Test HabitForge DB</button>
      <button class="sp-db-btn danger" id="sp-db-disconnect-btn" style="display:none">&#10005; Disconnect</button>
      <div class="sp-debug-log" id="sp-debug-log"></div>
    </div>
    <div style="height:16px"></div>
    <div class="help-link" onclick="closeSpSettings()">Close</div>
  </div>
</div>

<!-- CHRONOLUNA MODALS -->
<div class="cl-overlay" id="add-overlay">
  <div class="cl-modal">
    <div class="modal-handle"></div>
    <div class="cl-modal-title" id="modal-title-text">New Event</div>
    <div class="form-group"><label>Event Name</label><input type="text" id="ev-name" placeholder="e.g. Chinese New Year 2027"/></div>
    <div class="form-group"><label>Category</label>
      <div class="cat-grid" id="cat-grid">
        <button class="cat-btn selected" data-cat="&#127874;" data-color="#e74c3c">&#127874;<span>Birthday</span></button>
        <button class="cat-btn" data-cat="&#128141;" data-color="#9b59b6">&#128141;<span>Anniv.</span></button>
        <button class="cat-btn" data-cat="&#128302;" data-color="#c0392b">&#128302;<span>Festival</span></button>
        <button class="cat-btn" data-cat="&#127919;" data-color="#e67e22">&#127919;<span>Deadline</span></button>
        <button class="cat-btn" data-cat="&#9992;&#65039;" data-color="#3a6ea5">&#9992;&#65039;<span>Travel</span></button>
        <button class="cat-btn" data-cat="&#127891;" data-color="#27ae60">&#127891;<span>Academic</span></button>
        <button class="cat-btn" data-cat="&#128188;" data-color="#7f8c8d">&#128188;<span>Work</span></button>
        <button class="cat-btn" data-cat="&#10084;&#65039;" data-color="#e91e63">&#10084;&#65039;<span>Love</span></button>
        <button class="cat-btn" data-cat="&#127942;" data-color="#f39c12">&#127942;<span>Goal</span></button>
        <button class="cat-btn" data-cat="&#11088;" data-color="#2c3e50">&#11088;<span>Other</span></button>
      </div>
    </div>
    <div class="form-group"><label>Calendar Mode</label>
      <div class="cl-toggle-group" id="calmode-toggle">
        <button class="cl-toggle-btn active" data-calmode="gregorian">&#128197; Gregorian</button>
        <button class="cl-toggle-btn" data-calmode="chinese">&#128302; Chinese Lunar</button>
      </div>
    </div>
    <div class="form-group" id="greg-picker-row"><label>Date</label><input type="date" id="ev-date"/><div class="lunar-display" id="lunar-display" style="margin-top:8px">Select a date to see its lunar equivalent</div></div>
    <div class="form-group" id="lunar-picker-row" style="display:none"><label>Lunar Date</label>
      <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px;margin-bottom:8px">
        <div><label style="font-size:.66rem">Year &#24180;</label><select id="ln-year"></select></div>
        <div><label style="font-size:.66rem">Month &#26376;</label><select id="ln-month"></select></div>
        <div><label style="font-size:.66rem">Day &#26085;</label><select id="ln-day"></select></div>
      </div>
      <div style="margin-bottom:6px"><label class="notif-chip" id="ln-leap-label" style="display:none;width:fit-content"><input type="checkbox" id="ln-leap"> &#38470;&#26376; Leap month</label></div>
      <div class="lunar-display" id="lunar-greg-result">Equivalent Gregorian date will appear here</div>
    </div>
    <div class="form-group"><label>Repeat</label>
      <div class="cl-toggle-group">
        <button class="cl-toggle-btn active" data-repeat="none">Once</button>
        <button class="cl-toggle-btn" data-repeat="daily">Daily</button>
        <button class="cl-toggle-btn" data-repeat="monthly">Monthly</button>
        <button class="cl-toggle-btn" data-repeat="yearly">Yearly</button>
      </div>
    </div>
    <div class="form-group"><label>Reminders</label>
      <div class="notif-grid">
        <label class="notif-chip" data-days="0"><input type="checkbox" value="0"> On the day</label>
        <label class="notif-chip" data-days="1"><input type="checkbox" value="1"> 1 day before</label>
        <label class="notif-chip" data-days="7"><input type="checkbox" value="7"> 1 week before</label>
        <label class="notif-chip" data-days="30"><input type="checkbox" value="30"> 1 month before</label>
      </div>
    </div>
    <div class="form-group"><label>Notes (optional)</label><textarea id="ev-notes" placeholder="Gift ideas, personal messages&hellip;"></textarea></div>
    <button class="btn-primary" id="save-btn">Save Event</button>
    <button class="btn-secondary" id="delete-btn" style="display:none;color:#c0392b;border-color:#c0392b">&#128465; Delete Event</button>
    <button class="btn-secondary" id="cancel-btn">Cancel</button>
  </div>
</div>
<div class="cl-overlay" id="detail-overlay">
  <div class="cl-modal">
    <div class="modal-handle"></div>
    <div class="detail-card-big">
      <div id="detail-icon" style="font-size:2.5rem"></div>
      <div class="detail-event-name" id="detail-name"></div>
      <div style="color:var(--cl-muted);font-size:.8rem;font-family:'DM Sans',sans-serif" id="detail-lunar-label"></div>
      <div class="detail-countdown-grid" id="detail-countdown-grid"></div>
      <div style="color:var(--cl-muted);font-size:.8rem;font-family:'DM Sans',sans-serif" id="detail-date-str"></div>
    </div>
    <div id="detail-notes-section" style="margin-bottom:16px;display:none">
      <label style="display:block;font-size:.73rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted);margin-bottom:6px;font-family:'DM Sans',sans-serif">Notes</label>
      <div id="detail-notes" style="background:var(--paper2);border-radius:10px;padding:12px;font-size:.88rem;line-height:1.6;font-family:'DM Sans',sans-serif"></div>
    </div>
    <div style="display:flex;flex-wrap:wrap;gap:8px;margin-bottom:16px">
      <button class="share-btn" id="share-link-btn">&#128279; Copy Link</button>
      <button class="share-btn" id="share-img-btn">&#128444; Share Card</button>
      <button class="share-btn" id="edit-from-detail-btn">&#9999;&#65039; Edit</button>
    </div>
    <button class="btn-secondary" id="detail-close-btn">Close</button>
  </div>
</div>
<div class="cl-overlay" id="settings-overlay">
  <div class="cl-modal">
    <div class="modal-handle"></div>
    <div class="cl-modal-title">Settings</div>
    <div class="settings-row"><div><div class="settings-label">Dark Mode</div></div><div class="toggle-switch" id="dark-toggle"></div></div>
    <div class="settings-row"><div><div class="settings-label">Browser Notifications</div><div class="settings-sub">Get reminded before events</div></div><div class="toggle-switch" id="notif-toggle"></div></div>
    <div class="settings-row"><div><div class="settings-label">Show Lunar Date</div><div class="settings-sub">Display Chinese calendar on cards</div></div><div class="toggle-switch on" id="lunar-toggle"></div></div>
    <div style="margin-top:18px">
      <div class="settings-label" style="margin-bottom:10px;font-size:.76rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted)">Export</div>
      <button class="export-btn" id="export-json-btn">&#128228; Export Events (JSON)</button>
      <button class="export-btn" id="export-ics-btn">&#128197; Export as .ics Calendar</button>
    </div>
    <div style="margin-top:14px">
      <div class="settings-label" style="margin-bottom:8px;font-size:.76rem;letter-spacing:1px;text-transform:uppercase;color:var(--cl-muted)">Supabase &mdash; Events</div>
      <div class="sb-settings-card">
        <div style="font-size:.84rem;font-weight:500;font-family:'DM Sans',sans-serif" id="sb-settings-status-label">Not connected</div>
        <div class="sb-settings-url" id="sb-settings-url"></div>
        <div style="font-size:.73rem;color:var(--cl-muted);margin:8px 0;line-height:1.5;font-family:'DM Sans',sans-serif" id="sb-storage-hint">&#128241; Data saved in this browser only.</div>
        <button class="sb-reconnect-btn" id="sb-reconfigure-btn">&#9881;&#65039; Connect Supabase</button>
        <button class="sb-reconnect-btn" id="sb-test-btn" style="display:none">&#128269; Test Write</button>
        <button class="sb-disconnect-btn" id="sb-disconnect-btn" style="display:none">&#10005; Disconnect</button>
        <div id="sb-debug-log" style="display:none;margin-top:10px;background:var(--paper);border:1px solid var(--gold);border-radius:8px;padding:10px;font-size:.7rem;font-family:monospace;color:var(--ink);max-height:130px;overflow-y:auto;line-height:1.6;white-space:pre-wrap"></div>
      </div>
    </div>
    <button class="btn-secondary" id="settings-close-btn" style="margin-top:12px">Close</button>
  </div>
</div>
<div id="cl-supabase-overlay">
  <div class="sb-modal-inner">
    <div class="sb-logo"><span class="sb-logo-icon">&#128302;</span><div class="sb-logo-title">ChronoLuna</div><div class="sb-logo-sub">Event Countdown</div></div>
    <div class="sb-info-box">Connect Supabase to sync your events across all devices.</div>
    <div class="sb-divider">Connect to Supabase</div>
    <div class="sb-input-wrap"><label>Project URL</label><input type="url" id="sb-url-input" placeholder="https://xxxx.supabase.co" autocomplete="off" spellcheck="false"/></div>
    <div class="sb-input-wrap"><label>Anon / Public Key</label><input type="password" id="sb-key-input" placeholder="eyJhbGci&hellip;" autocomplete="off" spellcheck="false"/><button id="sb-eye-btn" style="position:absolute;right:10px;bottom:10px;background:none;border:none;cursor:pointer;font-size:16px;color:var(--cl-muted);padding:2px">&#128065;</button></div>
    <div class="sb-status" id="sb-status"><div class="sb-status-dot"></div><span id="sb-status-msg"></span></div>
    <button class="sb-btn-connect" id="sb-connect-btn"><span id="sb-connect-label">&#128279; Connect &amp; Sync</span></button>
    <button class="sb-btn-local" id="sb-local-btn">Continue without Supabase (local only)</button>
    <div class="sb-privacy">&#128274; Credentials stored only in this browser's localStorage.</div>
  </div>
</div>

<!-- HABITFORGE MODALS -->
<div id="hf-campaign-modal" class="hf-mwrap" onclick="hfBgClose(event,'hf-campaign-modal')">
  <div class="hf-modal">
    <div class="hf-mhdr"><h3 id="hf-cm-title">New Campaign</h3><button class="hf-mclose" onclick="hfCloseModal('hf-campaign-modal')">&#10005;</button></div>
    <div class="hf-mbody">
      <div class="hf-fg"><label>Campaign Name *</label><input id="hf-c-name" type="text" placeholder="e.g. Morning Run"/></div>
      <div class="hf-fg"><label>Description</label><textarea id="hf-c-desc" rows="2" placeholder="What's this habit about?"></textarea></div>
      <div class="hf-frow">
        <div class="hf-fg" style="margin-bottom:0"><label>Start Date</label><input id="hf-c-start" type="date"/></div>
        <div class="hf-fg" style="margin-bottom:0"><label>End Date (optional)</label><input id="hf-c-end" type="date"/></div>
      </div>
      <div class="hf-frow">
        <div class="hf-fg" style="margin-bottom:0"><label>Points per Check-in</label><input id="hf-c-pts" type="number" value="10" min="1" max="9999" oninput="hfUpdateTierPreview()"/></div>
        <div class="hf-fg" style="margin-bottom:0"><label>Emoji</label><input id="hf-c-emoji" type="text" placeholder="&#127939;" maxlength="4"/></div>
      </div>
      <div class="hf-tier-preview"><div class="hf-tp-label">&#128200; Streak reward growth</div><div class="hf-tp-grid" id="hf-tier-preview-grid"></div></div>
      <div class="hf-fg"><label>Frequency</label>
        <select id="hf-c-freq" onchange="hfFreqChange()">
          <option value="daily">Every day</option>
          <option value="weekdays">Weekdays only (Mon&ndash;Fri)</option>
          <option value="weekends">Weekends only (Sat&ndash;Sun)</option>
          <option value="custom">Custom days&hellip;</option>
        </select>
      </div>
      <div id="hf-custom-days" class="hf-dpick" style="display:none;margin-bottom:.75rem">
        <label>Select active days</label>
        <div class="hf-drow">
          <button type="button" class="hf-dbtn" data-d="0">Su</button><button type="button" class="hf-dbtn" data-d="1">Mo</button><button type="button" class="hf-dbtn" data-d="2">Tu</button><button type="button" class="hf-dbtn" data-d="3">We</button><button type="button" class="hf-dbtn" data-d="4">Th</button><button type="button" class="hf-dbtn" data-d="5">Fr</button><button type="button" class="hf-dbtn" data-d="6">Sa</button>
        </div>
      </div>
    </div>
    <div class="hf-mfoot">
      <button class="hf-btn-ghost" onclick="hfCloseModal('hf-campaign-modal')">Cancel</button>
      <button class="hf-btn-green" id="hf-cm-save" onclick="hfSaveCampaign()">Create Campaign</button>
    </div>
  </div>
</div>
<div id="hf-reward-modal" class="hf-mwrap" onclick="hfBgClose(event,'hf-reward-modal')">
  <div class="hf-modal">
    <div class="hf-mhdr"><h3>New Reward Milestone</h3><button class="hf-mclose" onclick="hfCloseModal('hf-reward-modal')">&#10005;</button></div>
    <div class="hf-mbody">
      <div class="hf-fg"><label>Reward Name *</label><input id="hf-r-name" type="text" placeholder="e.g. 7-Day Warrior"/></div>
      <div class="hf-fg"><label>Description</label><textarea id="hf-r-desc" rows="2" placeholder="Describe the achievement"></textarea></div>
      <div class="hf-fg"><label>Campaign (optional)</label><select id="hf-r-camp"><option value="">Any campaign</option></select></div>
      <div class="hf-frow">
        <div class="hf-fg" style="margin-bottom:0"><label>Trigger Type</label><select id="hf-r-ttype"><option value="streak">Streak (consecutive days)</option><option value="total">Total check-ins</option><option value="points">Total points earned</option></select></div>
        <div class="hf-fg" style="margin-bottom:0"><label>Target Value</label><input id="hf-r-tval" type="number" value="7" min="1"/></div>
      </div>
      <div class="hf-frow">
        <div class="hf-fg" style="margin-bottom:0"><label>Bonus Points</label><input id="hf-r-bonus" type="number" value="50" min="0"/></div>
        <div class="hf-fg" style="margin-bottom:0"><label>Badge Emoji</label><input id="hf-r-emoji" type="text" placeholder="&#127942;" maxlength="4"/></div>
      </div>
      <div class="hf-fg"><label>Repeatable?</label><select id="hf-r-repeat"><option value="false">One-time only</option><option value="true">Repeating</option></select></div>
    </div>
    <div class="hf-mfoot">
      <button class="hf-btn-ghost" onclick="hfCloseModal('hf-reward-modal')">Cancel</button>
      <button class="hf-btn-green" onclick="hfSaveReward()">Create Reward</button>
    </div>
  </div>
</div>

<div class="hf-toast" id="hf-toast"></div>
<div class="confetti-container" id="confetti-container"></div>
<div id="cl-toast"></div>
<div class="sp-toast" id="sp-toast"></div>

<script>
/* PWA */
(function(){
  const I="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Crect width='100' height='100' fill='%238b6340' rx='20'/%3E%3C/svg%3E";
  const m={name:"Labdeck",short_name:"Labdeck",start_url:"./",display:"standalone",background_color:"#faf7f2",theme_color:"#8b6340",icons:[{src:I,sizes:"192x192",type:"image/svg+xml",purpose:"any maskable"}]};
  const b=new Blob([JSON.stringify(m)],{type:'application/json'});
  document.getElementById('manifest-link').href=URL.createObjectURL(b);
})();
if('serviceWorker'in navigator){const sw=`const C='ld-v3';self.addEventListener('install',e=>{self.skipWaiting();});self.addEventListener('activate',e=>{e.waitUntil(clients.claim());});self.addEventListener('fetch',e=>{if(e.request.url.includes('supabase')||e.request.url.includes('fonts')){e.respondWith(fetch(e.request).catch(()=>new Response('',{status:503})));return;}e.respondWith(caches.open(C).then(c=>c.match(e.request).then(r=>{const f=fetch(e.request).then(res=>{c.put(e.request,res.clone());return res;}).catch(()=>null);return r||f;})));});`;navigator.serviceWorker.register(URL.createObjectURL(new Blob([sw],{type:'application/javascript'}))).catch(()=>{});}

/* ROUTER */
function go(id){
  document.querySelectorAll('.screen').forEach(s=>s.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  const clFab=document.getElementById('add-btn');if(clFab)clFab.style.display=id==='chronoluna'?'flex':'none';
  const spFab=document.querySelector('.sp-fab');if(spFab)spFab.style.display=(id==='main'&&isCurrentMonth())?'flex':'none';
  if(id==='dashboard'){renderDashboard();}
  if(id==='main'){render();}
  if(id==='chronoluna'){renderAll();renderDashEventBanner();}
  if(id==='habitforge'){
    const td=new Date().toLocaleDateString('en-US',{weekday:'short',month:'short',day:'numeric'});
    document.getElementById('hf-dash-date').textContent=td;
    document.getElementById('hf-ci-date').textContent=td;
    hfRenderAll();
  }
  if(id==='lotto'){setTimeout(()=>{loRenderChart();},50);}
}

/* SPENDLY DATA */
const CATS=[
  {id:'food',name:'Food & Drinks',icon:'🍜',hex:'#c0622a'},
  {id:'shopping',name:'Shopping',icon:'🛍️',hex:'#7a5535'},
  {id:'travel',name:'Travel',icon:'✈️',hex:'#3a7a6a'},
  {id:'services',name:'Services',icon:'🔧',hex:'#4a6080'},
  {id:'entertainment',name:'Entertainment',icon:'🎬',hex:'#7a4a80'},
  {id:'health',name:'Health',icon:'💊',hex:'#3a7a3a'},
  {id:'transport',name:'Transport',icon:'🚌',hex:'#6a6a20'},
  {id:'subscription',name:'Subscriptions',icon:'🔁',hex:'#7a3a5a'},
  {id:'investments',name:'Investments',icon:'📈',hex:'#2a6a4a'},
  {id:'family',name:'Family',icon:'🏠',hex:'#8a5a2a'},
  {id:'misc',name:'Miscellaneous',icon:'📦',hex:'#7a6a50'},
  {id:'pokemon',name:'Pokémon',icon:'⬜',hex:'#7b52ab',svg:true},
  {id:'mahjong',name:'Mahjong',icon:'🀄',hex:'#b5451b'}
];
const SHORT={'Food & Drinks':'Food','Miscellaneous':'Misc','Entertainment':'Entmt','Subscriptions':'Subs','Investments':'Invest'};
function short(n){return SHORT[n]||n.split(' ')[0]}
function catIcon(c,size=20){if(c.svg)return`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" width="${size}" height="${size}"><path d="M4,18 A14,14 0 0,1 32,18 Z" fill="#e63535"/><path d="M4,18 A14,14 0 0,0 32,18 Z" fill="#f5f5f5"/><circle cx="18" cy="18" r="14" fill="none" stroke="#222" stroke-width="2"/><line x1="4" y1="18" x2="32" y2="18" stroke="#222" stroke-width="2.2"/><circle cx="18" cy="18" r="4.5" fill="#222"/><circle cx="18" cy="18" r="3" fill="#fff"/></svg>`;return`<span style="font-size:${size}px;line-height:1">${c.icon}</span>`;}

let S={supabaseUrl:'',supabaseKey:'',cur:'$',name:'User',txns:[],filter:'all',viewOffset:0,editId:null,selCat:'food'};
let spClient=null;
function loadS(){try{const d=localStorage.getItem('labdeck_sb');if(d){const p=JSON.parse(d);S={...S,...p};}}catch(e){}}
function saveS(){localStorage.setItem('labdeck_sb',JSON.stringify({supabaseUrl:S.supabaseUrl,supabaseKey:S.supabaseKey,cur:S.cur,name:S.name}));}
function cacheTxns(){localStorage.setItem('labdeck_txns',JSON.stringify(S.txns));}
function loadCachedTxns(){try{const d=localStorage.getItem('labdeck_txns');if(d)S.txns=JSON.parse(d);}catch(e){}}
function greetingText(){const h=new Date().getHours();const g=h<12?'Good morning':h<17?'Good afternoon':'Good evening';return S.name?`${g}, ${S.name}`:g;}

async function initSupabase(){
  const url=document.getElementById('supabase-url').value.trim();
  const key=document.getElementById('supabase-key').value.trim();
  const cur=document.getElementById('cur-sym').value.trim()||'$';
  const name=document.getElementById('user-name').value.trim();
  if(!url.startsWith('https://')){spToast('URL must start with https://','err');return;}
  S.supabaseUrl=url;S.supabaseKey=key;S.cur=cur;S.name=name||'User';
  saveS();
  try{
    const{createClient}=supabase;
    spClient=createClient(url,key);
    const{error}=await spClient.from('expenses').select('id',{count:'exact',head:true});
    if(error)throw new Error(error.message);
    hfInitWithClient(spClient);
    go('dashboard');await fetchTxns();
  }catch(e){spToast(`Connection failed: ${e.message}`,'err');spClient=null;}
}
function goGuide(){go('guide');}

function openSpendlySettings(){
  updateSpDbCard();
  document.getElementById('sp-dark-toggle').classList.toggle('on',clSettings.dark);
  document.getElementById('sp-notif-toggle').classList.toggle('on',Notification&&Notification.permission==='granted');
  document.getElementById('sp-settings-overlay').classList.add('open');
}
function closeSpSettings(){document.getElementById('sp-settings-overlay').classList.remove('open');}
function updateSpDbCard(){
  const sl=document.getElementById('sp-db-status-lbl'),ul=document.getElementById('sp-db-url-lbl');
  const db=document.getElementById('sp-db-disconnect-btn'),tb=document.getElementById('sp-db-test-btn');
  const thf=document.getElementById('sp-db-test-hf-btn'),rb=document.getElementById('sp-db-reconf-btn');
  const hint=document.getElementById('sp-db-hint');
  if(spClient&&S.supabaseUrl){
    sl.textContent='✅ Connected to Supabase';sl.style.color='#3a7a3a';ul.textContent=S.supabaseUrl;
    db.style.display='inline-flex';tb.style.display='inline-flex';thf.style.display='inline-flex';
    rb.textContent='✏️ Edit Connection';
    if(hint)hint.textContent='☁️ Data synced to Supabase — available on all devices.';
  }else{
    sl.textContent='○ Not connected';sl.style.color='var(--muted)';ul.textContent='';
    db.style.display='none';tb.style.display='none';thf.style.display='none';
    rb.textContent='⚙️ Connect Supabase';
    if(hint)hint.textContent='📱 Data saved in this browser only. Connect Supabase for cloud sync.';
  }
}
function spDisconnect(){
  if(!confirm('Disconnect Supabase and clear data?'))return;
  localStorage.removeItem('labdeck_sb');localStorage.removeItem('labdeck_txns');
  S={supabaseUrl:'',supabaseKey:'',cur:'$',name:'User',txns:[],filter:'all',viewOffset:0,editId:null,selCat:'food'};
  spClient=null;hfResetClient();closeSpSettings();go('setup');
}
async function spTestDb(){
  const log=document.getElementById('sp-debug-log');log.textContent='';log.style.display='block';log.style.color='var(--text)';
  const ts=()=>new Date().toLocaleTimeString();
  if(!spClient){log.textContent+=`[${ts()}] ❌ Not connected.\n`;return;}
  try{const{data,error}=await spClient.from('expenses').select('id').limit(1);if(error)throw error;log.textContent+=`[${ts()}] ✓ expenses OK — rows: ${data?data.length:0}\n`;}
  catch(e){log.textContent+=`[${ts()}] ❌ expenses: ${e.message}\n`;log.style.color='var(--danger)';return;}
  log.textContent+=`[${ts()}] ✅ Spendly DB OK!\n`;
}
async function spTestHfDb(){
  const log=document.getElementById('sp-debug-log');log.textContent='';log.style.display='block';log.style.color='var(--text)';
  const ts=()=>new Date().toLocaleTimeString();
  if(!spClient){log.textContent+=`[${ts()}] ❌ Not connected.\n`;return;}
  const tables=['hf_settings','hf_campaigns','hf_checkins','hf_rewards','hf_earned'];
  log.textContent+=`[${ts()}] Testing HabitForge tables...\n`;
  for(const tbl of tables){
    try{const{data,error}=await spClient.from(tbl).select('*').limit(1);if(error)throw error;log.textContent+=`[${ts()}] ✓ ${tbl} OK (${data?data.length:0} rows)\n`;}
    catch(e){log.textContent+=`[${ts()}] ❌ ${tbl} MISSING/ERROR: ${e.message}\n`;log.style.color='var(--danger)';}
  }
  log.textContent+=`[${ts()}] Done. ❌ tables need the HabitForge SQL from the Setup Guide.\n`;
}
function spExportCSV(){if(!S.txns.length){spToast('No transactions to export','err');return;}const rows=[['Date','Name','Category','Amount'],...S.txns.map(t=>[new Date(t.date).toLocaleDateString(),`"${(t.name||'').replace(/"/g,'""')}"`,t.category,t.amount.toFixed(2)])];const csv=rows.map(r=>r.join(',')).join('\n');const a=document.createElement('a');a.href='data:text/csv;charset=utf-8,'+encodeURIComponent(csv);a.download=`spendly-${new Date().toISOString().slice(0,10)}.csv`;a.click();spToast('Exported CSV ✓','ok');}
function spExportJSON(){if(!S.txns.length){spToast('No transactions to export','err');return;}const a=document.createElement('a');a.href='data:application/json;charset=utf-8,'+encodeURIComponent(JSON.stringify(S.txns,null,2));a.download=`spendly-${new Date().toISOString().slice(0,10)}.json`;a.click();spToast('Exported JSON ✓','ok');}

document.getElementById('sp-settings-overlay').addEventListener('click',e=>{if(e.target===document.getElementById('sp-settings-overlay'))closeSpSettings();});
document.getElementById('sp-dark-toggle').addEventListener('click',function(){clSettings.dark=!clSettings.dark;applyTheme();saveClSettings();this.classList.toggle('on',clSettings.dark);});
document.getElementById('sp-notif-toggle').addEventListener('click',async function(){if(Notification&&Notification.permission!=='granted'){const p=await Notification.requestPermission();this.classList.toggle('on',p==='granted');spToast(p==='granted'?'Notifications enabled ✓':'Permission denied','ok');}else spToast('Notifications already enabled','ok');});
document.getElementById('sp-db-reconf-btn').addEventListener('click',()=>{closeSpSettings();go('setup');});
document.getElementById('sp-db-disconnect-btn').addEventListener('click',spDisconnect);
document.getElementById('sp-db-test-btn').addEventListener('click',spTestDb);
document.getElementById('sp-db-test-hf-btn').addEventListener('click',spTestHfDb);
document.getElementById('sp-export-csv-btn').addEventListener('click',spExportCSV);
document.getElementById('sp-export-json-btn').addEventListener('click',spExportJSON);

async function fetchTxns(){
  setSyncStatus('syncing','Loading...');
  if(spClient){
    try{const{data,error}=await spClient.from('expenses').select('*').order('date',{ascending:false});if(error)throw error;S.txns=data.map(r=>({id:r.id,name:r.name,amount:Number(r.amount),category:r.category,date:r.date}));cacheTxns();setSyncStatus('ok',`${S.txns.length} entries · synced`);spToast('Synced ✓','ok');}
    catch(e){setSyncStatus('err','Sync failed');spToast(e.message,'err');}
  }else{loadCachedTxns();setSyncStatus('ok','Local data');}
  renderDashboard();render();
}
async function refreshAll(){await fetchTxns();renderAll();renderDashEventBanner();}
function setSyncStatus(state,label){const dot=document.getElementById('sync-dot');const lbl=document.getElementById('sync-label');const btn=document.getElementById('sp-refresh-btn');dot.className='sync-dot'+(state?' '+state:'');lbl.textContent=label;if(btn)btn.classList.toggle('spinning',state==='syncing');}
function viewDate(){const now=new Date();const d=new Date(now.getFullYear(),now.getMonth()+S.viewOffset,1);return{mo:d.getMonth(),yr:d.getFullYear()};}
function isCurrentMonth(){return S.viewOffset===0;}
function render(){
  document.getElementById('sp-greeting').textContent=greetingText();
  document.getElementById('cur-disp').textContent=S.cur;document.getElementById('mcur').textContent=S.cur;
  const{mo,yr}=viewDate();const vDate=new Date(yr,mo,1);
  document.getElementById('mlbl').textContent=isCurrentMonth()?`This month — ${vDate.toLocaleString('default',{month:'long',year:'numeric'})}`:vDate.toLocaleString('default',{month:'long',year:'numeric'});
  const mTxns=S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===mo&&d.getFullYear()===yr;});
  const tot=mTxns.reduce((a,t)=>a+t.amount,0);
  document.getElementById('total').textContent=tot.toFixed(2);
  document.getElementById('txn-count').textContent=`${mTxns.length} transaction${mTxns.length!==1?'s':''}`;
  const fab=document.querySelector('.sp-fab');if(fab)fab.style.display=isCurrentMonth()?'flex':'none';
  buildFilterPills();renderChart(mTxns);spRenderList(mTxns);
}
function renderChart(mTxns){
  const total=mTxns.reduce((a,t)=>a+t.amount,0);
  const empty=document.getElementById('sp-pie-empty'),wrap=document.getElementById('sp-pie-wrap');
  if(!total){empty.style.display='block';wrap.style.display='none';renderSpLine();return;}
  empty.style.display='none';wrap.style.display='flex';
  const data=CATS.map(c=>({cat:c,amt:mTxns.filter(t=>t.category===c.id).reduce((a,t)=>a+t.amount,0)})).filter(d=>d.amt>0).sort((a,b)=>b.amt-a.amt);
  const canvas=document.getElementById('sp-pie-canvas');const SIZE=120;const dpr=window.devicePixelRatio||1;
  canvas.width=SIZE*dpr;canvas.height=SIZE*dpr;canvas.style.width=SIZE+'px';canvas.style.height=SIZE+'px';
  const ctx=canvas.getContext('2d');ctx.scale(dpr,dpr);
  const cx=SIZE/2,cy=SIZE/2,r=SIZE/2-2;ctx.clearRect(0,0,SIZE,SIZE);
  let angle=-Math.PI/2;
  data.forEach(d=>{const slice=(d.amt/total)*Math.PI*2;ctx.beginPath();ctx.moveTo(cx,cy);ctx.arc(cx,cy,r,angle,angle+slice);ctx.closePath();ctx.fillStyle=d.cat.hex;ctx.fill();ctx.beginPath();ctx.moveTo(cx,cy);ctx.lineTo(cx+r*Math.cos(angle),cy+r*Math.sin(angle));ctx.strokeStyle='#faf7f2';ctx.lineWidth=1.5;ctx.stroke();angle+=slice;});
  const legend=document.getElementById('sp-legend');legend.innerHTML='';
  data.forEach(d=>{const pct=Math.round((d.amt/total)*100);const row=document.createElement('div');row.className='legend-row';row.innerHTML=`<div class="legend-dot" style="background:${d.cat.hex}"></div><div class="legend-name" style="color:${d.cat.hex}">${short(d.cat.name).toUpperCase()}</div><div class="legend-amt">${S.cur}${d.amt.toFixed(0)}</div><div class="legend-pct">${pct}%</div>`;row.onclick=()=>{S.filter=d.cat.id;buildFilterPills();const{mo,yr}=viewDate();spRenderList(S.txns.filter(t=>{const dt=new Date(t.date);return dt.getMonth()===mo&&dt.getFullYear()===yr;}));};legend.appendChild(row);});
  renderSpLine();
}
function renderSpLine(){
  const yr=new Date().getFullYear();
  const monthly=Array.from({length:12},(_,i)=>S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===i&&d.getFullYear()===yr;}).reduce((a,t)=>a+t.amount,0));
  const empty=document.getElementById('sp-line-empty'),wrap=document.getElementById('sp-line-wrap');
  if(!monthly.some(v=>v>0)){empty.style.display='block';wrap.style.display='none';return;}
  empty.style.display='none';wrap.style.display='block';
  const canvas=document.getElementById('sp-line-canvas');
  const W=canvas.parentElement.getBoundingClientRect().width||260;const H=130;const dpr=window.devicePixelRatio||1;
  canvas.width=W*dpr;canvas.height=H*dpr;canvas.style.width=W+'px';canvas.style.height=H+'px';
  const ctx=canvas.getContext('2d');ctx.scale(dpr,dpr);ctx.clearRect(0,0,W,H);
  const pad={top:12,bottom:24,left:8,right:8};const pw=W-pad.left-pad.right;const ph=H-pad.top-pad.bottom;
  const maxV=Math.max(...monthly,1);const curMo=new Date().getMonth();
  const ML=['J','F','M','A','M','J','J','A','S','O','N','D'];
  ctx.strokeStyle='rgba(140,110,70,0.08)';ctx.lineWidth=1;
  [0,.25,.5,.75,1].forEach(v=>{const y=pad.top+ph*(1-v);ctx.beginPath();ctx.moveTo(pad.left,y);ctx.lineTo(pad.left+pw,y);ctx.stroke();});
  const pts=monthly.map((v,i)=>({x:pad.left+(i/11)*pw,y:pad.top+ph*(1-v/maxV)}));
  const grad=ctx.createLinearGradient(0,pad.top,0,pad.top+ph);grad.addColorStop(0,'rgba(139,99,64,0.18)');grad.addColorStop(1,'rgba(139,99,64,0.01)');
  ctx.beginPath();ctx.moveTo(pts[0].x,pad.top+ph);pts.forEach(p=>ctx.lineTo(p.x,p.y));ctx.lineTo(pts[pts.length-1].x,pad.top+ph);ctx.closePath();ctx.fillStyle=grad;ctx.fill();
  ctx.beginPath();pts.forEach((p,i)=>i===0?ctx.moveTo(p.x,p.y):ctx.lineTo(p.x,p.y));ctx.strokeStyle='#8b6340';ctx.lineWidth=2;ctx.lineJoin='round';ctx.stroke();
  pts.forEach((p,i)=>{const isCur=i===curMo;ctx.beginPath();ctx.arc(p.x,p.y,isCur?4.5:3,0,Math.PI*2);ctx.fillStyle=isCur?'#8b6340':'#d4a96a';ctx.fill();if(isCur){ctx.strokeStyle='#fff';ctx.lineWidth=1.5;ctx.stroke();}ctx.fillStyle='rgba(168,148,122,0.8)';ctx.font='8px DM Mono,monospace';ctx.textAlign='center';ctx.fillText(ML[i],p.x,H-6);});
}
function onSpChartScroll(){const el=document.getElementById('sp-charts-carousel');const idx=Math.round(el.scrollLeft/(el.clientWidth||el.scrollWidth));document.querySelectorAll('#sp-cdots .cdot').forEach((d,i)=>d.classList.toggle('on',i===idx));}
function spRenderList(mTxns){
  const l=document.getElementById('txn-list');
  let txns=[...mTxns].sort((a,b)=>new Date(b.date)-new Date(a.date));
  if(S.filter!=='all')txns=txns.filter(t=>t.category===S.filter);
  if(!txns.length){l.innerHTML=`<div class="empty"><span class="ico">💸</span>No transactions yet.<br>Tap + to log your first one.</div>`;return;}
  l.innerHTML='';
  txns.forEach(t=>{const c=CATS.find(x=>x.id===t.category)||CATS[CATS.length-1];const ds=new Date(t.date).toLocaleString('en-SG',{day:'numeric',month:'short',hour:'2-digit',minute:'2-digit'});const div=document.createElement('div');div.className='txn';div.style.cursor='pointer';div.onclick=()=>openEditTxn(t.id);div.innerHTML=`<div class="txn-ico" style="background:${c.hex}18">${catIcon(c,20)}</div><div class="txn-info"><div class="txn-name">${t.name||c.name}</div><div class="txn-sub">${c.name} · ${ds}</div></div><div class="txn-amt" style="color:${c.hex}">${S.cur}${t.amount.toFixed(2)}</div><button class="del-btn" onclick="event.stopPropagation();deleteTxn('${t.id}')">✕</button>`;l.appendChild(div);});
}
async function deleteTxn(id){if(!confirm('Permanently delete?'))return;if(spClient){const{error}=await spClient.from('expenses').delete().eq('id',id);if(error){spToast(error.message,'err');return;}}S.txns=S.txns.filter(t=>t.id!==id);cacheTxns();render();renderDashboard();spToast('Deleted ✓','ok');}
function buildCatRow(){const r=document.getElementById('cat-row');r.innerHTML='';CATS.forEach(c=>{const b=document.createElement('button');b.className='cbtn'+(c.id===S.selCat?' on':'');b.innerHTML=`<span class="cico">${catIcon(c,20)}</span>${short(c.name)}`;b.onclick=()=>{S.selCat=c.id;document.querySelectorAll('.cbtn').forEach(x=>x.classList.remove('on'));b.classList.add('on');};r.appendChild(b);});}
function openAddTxn(){S.editId=null;document.getElementById('sp-modal-title').textContent='New transaction';document.getElementById('sp-modal-btn').textContent='Log transaction →';document.getElementById('sp-amt-input').value='';document.getElementById('txn-name').value='';buildCatRow();document.getElementById('sp-overlay').classList.add('open');setTimeout(()=>document.getElementById('sp-amt-input').focus(),300);}
function openEditTxn(id){const t=S.txns.find(x=>x.id===id);if(!t)return;S.editId=id;S.selCat=t.category;document.getElementById('sp-modal-title').textContent='Edit transaction';document.getElementById('sp-modal-btn').textContent='Save changes →';document.getElementById('sp-amt-input').value=t.amount;document.getElementById('txn-name').value=t.name;buildCatRow();document.getElementById('sp-overlay').classList.add('open');}
function closeSpModal(){document.getElementById('sp-overlay').classList.remove('open');}
async function submitTxn(){S.editId?await updateTxn():await addTxn();}
async function addTxn(){const amount=parseFloat(document.getElementById('sp-amt-input').value);if(!amount||amount<=0){spToast('Enter an amount','err');return;}const name=document.getElementById('txn-name').value.trim()||CATS.find(c=>c.id===S.selCat)?.name||'Expense';const newRow={name,amount,category:S.selCat,date:new Date().toISOString()};if(spClient){const{data,error}=await spClient.from('expenses').insert([newRow]).select();if(error){spToast(error.message,'err');return;}if(data&&data[0])S.txns.unshift(data[0]);}else{S.txns.unshift({...newRow,id:'local_'+Date.now()});spToast('Saved locally (no Supabase)','ok');}cacheTxns();closeSpModal();render();renderDashboard();if(spClient)spToast('Transaction saved ✓','ok');}
async function updateTxn(){const amount=parseFloat(document.getElementById('sp-amt-input').value);if(!amount||amount<=0){spToast('Enter an amount','err');return;}const name=document.getElementById('txn-name').value.trim()||CATS.find(c=>c.id===S.selCat)?.name||'Expense';if(spClient&&S.editId){const{error}=await spClient.from('expenses').update({name,amount,category:S.selCat}).eq('id',S.editId);if(error){spToast(error.message,'err');return;}}const idx=S.txns.findIndex(t=>t.id===S.editId);if(idx>=0)S.txns[idx]={...S.txns[idx],name,amount,category:S.selCat};cacheTxns();closeSpModal();render();renderDashboard();spToast('Updated ✓','ok');}
function openMonthPicker(){const now=new Date();const rows=[];for(let i=0;i<=18;i++){const d=new Date(now.getFullYear(),now.getMonth()-i,1);rows.push({offset:-i,date:d});}const list=document.getElementById('month-picker-list');list.innerHTML='';rows.forEach(r=>{const isCur=r.offset===S.viewOffset;const mTxns=S.txns.filter(t=>{const dt=new Date(t.date);return dt.getMonth()===r.date.getMonth()&&dt.getFullYear()===r.date.getFullYear();});const tot=mTxns.reduce((a,t)=>a+t.amount,0);const label=r.offset===0?'This month':r.date.toLocaleString('default',{month:'long',year:'numeric'});const row=document.createElement('div');row.className='month-row'+(isCur?' current':'');row.innerHTML=`<div><div class="month-row-label">${label}</div><div class="month-row-meta">${mTxns.length} transaction${mTxns.length!==1?'s':''}</div></div><div class="month-row-amt">${tot>0?S.cur+tot.toFixed(2):'—'}</div>`;row.onclick=()=>{S.viewOffset=r.offset;closeMonthPicker();render();};list.appendChild(row);});document.getElementById('sp-month-overlay').classList.add('open');}
function closeMonthPicker(){document.getElementById('sp-month-overlay').classList.remove('open');}
function buildFilterPills(){const container=document.getElementById('filter-row');if(!container)return;container.innerHTML='<div class="fpill" data-cat="all">All</div>'+CATS.map(c=>`<div class="fpill" data-cat="${c.id}">${short(c.name)}</div>`).join('');const pills=container.querySelectorAll('.fpill');pills.forEach(p=>{if(p.dataset.cat===S.filter)p.classList.add('on');p.onclick=()=>{S.filter=p.dataset.cat;pills.forEach(f=>f.classList.remove('on'));p.classList.add('on');const{mo,yr}=viewDate();spRenderList(S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===mo&&d.getFullYear()===yr;}));};});}
function spToast(msg,type){const el=document.getElementById('sp-toast');el.textContent=msg;el.className=`sp-toast show ${type}`;clearTimeout(window._spTT);window._spTT=setTimeout(()=>el.classList.remove('show'),2800);}
document.getElementById('sp-overlay').addEventListener('click',e=>{if(e.target===document.getElementById('sp-overlay'))closeSpModal();});
document.getElementById('sp-month-overlay').addEventListener('click',e=>{if(e.target===document.getElementById('sp-month-overlay'))closeMonthPicker();});

/* DASHBOARD */
const MY_APPS=[
  {name:'Spendly',desc:'Monthly expense tracker',icon:'💸',color:'#8b6340',screen:'main',tag:'Finance'},
  {name:'ChronoLuna',desc:'Event & countdown tracker',icon:'🏮',color:'#c0392b',screen:'chronoluna',tag:'Events'},
  {name:'HabitForge',desc:'Daily habit & streak tracker',icon:'✅',color:'#3dba6e',screen:'habitforge',tag:'Habits'},
  {name:'Lotto Oracle',desc:'Number prediction engine',icon:'🎰',color:'#00e5ff',screen:'lotto',tag:'Analytics'}
];
function renderAppsGrid(){document.getElementById('apps-grid').innerHTML=MY_APPS.map(app=>`<div class="app-card" onclick="${app.screen?`go('${app.screen}')`:''}" style="${!app.screen?'opacity:.6;cursor:default':''}"><div class="app-card-ico" style="background:${app.color}18">${app.icon}</div><div><div class="app-card-name">${app.name}</div><div class="app-card-desc">${app.desc}</div></div><div class="app-card-tag" style="background:${app.color}18;color:${app.color}">${app.tag}</div></div>`).join('');}
function renderDashboard(){
  document.getElementById('dash-greeting').textContent=greetingText();
  document.getElementById('dash-cur').textContent=S.cur;
  const now=new Date();const mo=now.getMonth(),yr=now.getFullYear();
  const mTxns=S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===mo&&d.getFullYear()===yr;});
  const total=mTxns.reduce((a,t)=>a+t.amount,0);
  const lastMo=mo===0?11:mo-1;const lastYr=mo===0?yr-1:yr;
  const lastTotal=S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===lastMo&&d.getFullYear()===lastYr;}).reduce((a,t)=>a+t.amount,0);
  const trendPct=lastTotal>0?((total-lastTotal)/lastTotal*100).toFixed(0):null;
  const trendStr=trendPct!==null?(trendPct>0?`▲ ${trendPct}% vs last month`:`▼ ${Math.abs(trendPct)}% vs last month`):'First month tracked';
  document.getElementById('dash-total').textContent=total.toFixed(2);
  document.getElementById('dash-count').textContent=`${mTxns.length} transaction${mTxns.length!==1?'s':''}`;
  document.getElementById('dash-month-name').textContent=now.toLocaleString('default',{month:'long',year:'numeric'});
  document.getElementById('dash-trend').textContent=trendStr;
  renderDashPie(mTxns,'dash-pie-canvas','dash-legend','dash-pie-empty','dash-pie-wrap',100);
  renderDashPie(mTxns,'dash-pie-canvas-t','dash-legend-t','dash-pie-empty-t','dash-pie-wrap-t',110);
  renderDashLine('dash-line-canvas','dash-line-empty','dash-line-wrap');
  renderDashLine('dash-line-canvas-t','dash-line-empty-t','dash-line-wrap-t');
  renderAppsGrid();applyChartLayout();renderDashEventBanner();
}
function renderDashEventBanner(){
  const banner=document.getElementById('event-banner');
  try{
    const now=new Date();now.setHours(0,0,0,0);
    const upcoming=events.map(ev=>{const d=new Date(getNextOccurrence(ev));d.setHours(0,0,0,0);return{...ev,diff:Math.ceil((d-now)/86400000)};}).filter(ev=>ev.diff>=0).sort((a,b)=>a.diff-b.diff);
    if(!upcoming.length){banner.classList.add('hidden');return;}
    const next=upcoming[0];
    document.getElementById('evb-name').textContent=next.name||'Upcoming Event';
    document.getElementById('evb-days').textContent=next.diff===0?'🎉':next.diff;
    document.getElementById('evb-sub').textContent=next.diff===0?'Today! Tap to celebrate →':`${next.diff===1?'Tomorrow':'in '+next.diff+' days'} · Tap to view all →`;
    banner.classList.remove('hidden');
    // Points pill
    const pill=document.getElementById('evb-pts-pill');
    const ptsVal=document.getElementById('evb-pts-val');
    if(hfTotalPts>0){ptsVal.textContent=hfTotalPts.toLocaleString();pill.style.display='flex';}
    else{pill.style.display='none';}
  }catch(e){banner.classList.add('hidden');}
}
function renderDashPie(mTxns,cid,lid,eid,wid,SIZE){
  const total=mTxns.reduce((a,t)=>a+t.amount,0);const empty=document.getElementById(eid),wrap=document.getElementById(wid);
  if(!total){empty.style.display='block';wrap.style.display='none';return;}
  empty.style.display='none';wrap.style.display='flex';
  const data=CATS.map(c=>({cat:c,amt:mTxns.filter(t=>t.category===c.id).reduce((a,t)=>a+t.amount,0)})).filter(d=>d.amt>0).sort((a,b)=>b.amt-a.amt);
  const canvas=document.getElementById(cid);const dpr=window.devicePixelRatio||1;
  canvas.width=SIZE*dpr;canvas.height=SIZE*dpr;canvas.style.width=SIZE+'px';canvas.style.height=SIZE+'px';
  const ctx=canvas.getContext('2d');ctx.scale(dpr,dpr);
  const cx=SIZE/2,cy=SIZE/2,r=SIZE/2-2;ctx.clearRect(0,0,SIZE,SIZE);let angle=-Math.PI/2;
  data.forEach(d=>{const slice=(d.amt/total)*Math.PI*2;ctx.beginPath();ctx.moveTo(cx,cy);ctx.arc(cx,cy,r,angle,angle+slice);ctx.closePath();ctx.fillStyle=d.cat.hex;ctx.fill();ctx.beginPath();ctx.moveTo(cx,cy);ctx.lineTo(cx+r*Math.cos(angle),cy+r*Math.sin(angle));ctx.strokeStyle='#faf7f2';ctx.lineWidth=1.5;ctx.stroke();angle+=slice;});
  const legend=document.getElementById(lid);legend.innerHTML='';
  data.slice(0,5).forEach(d=>{const pct=Math.round((d.amt/total)*100);const row=document.createElement('div');row.className='dash-legend-row';row.innerHTML=`<div class="dash-legend-dot" style="background:${d.cat.hex}"></div><div class="dash-legend-name" style="color:${d.cat.hex}">${short(d.cat.name)}</div><div class="dash-legend-pct">${S.cur}${d.amt.toFixed(0)} <span style="opacity:.6">${pct}%</span></div>`;legend.appendChild(row);});
}
function renderDashLine(cid,eid,wid){
  const yr=new Date().getFullYear();
  const monthly=Array.from({length:12},(_,i)=>S.txns.filter(t=>{const d=new Date(t.date);return d.getMonth()===i&&d.getFullYear()===yr;}).reduce((a,t)=>a+t.amount,0));
  const empty=document.getElementById(eid),wrap=document.getElementById(wid);
  if(!monthly.some(v=>v>0)){empty.style.display='block';wrap.style.display='none';return;}
  empty.style.display='none';wrap.style.display='block';
  const canvas=document.getElementById(cid);const W=canvas.parentElement.getBoundingClientRect().width||280;const H=parseInt(canvas.style.height)||130;const dpr=window.devicePixelRatio||1;
  canvas.width=W*dpr;canvas.height=H*dpr;canvas.style.width=W+'px';canvas.style.height=H+'px';
  const ctx=canvas.getContext('2d');ctx.scale(dpr,dpr);ctx.clearRect(0,0,W,H);
  const pad={top:12,bottom:24,left:8,right:8};const pw=W-pad.left-pad.right;const ph=H-pad.top-pad.bottom;
  const maxV=Math.max(...monthly,1);const curMo=new Date().getMonth();const ML=['J','F','M','A','M','J','J','A','S','O','N','D'];
  ctx.strokeStyle='rgba(140,110,70,0.08)';ctx.lineWidth=1;[0,.25,.5,.75,1].forEach(v=>{const y=pad.top+ph*(1-v);ctx.beginPath();ctx.moveTo(pad.left,y);ctx.lineTo(pad.left+pw,y);ctx.stroke();});
  const pts=monthly.map((v,i)=>({x:pad.left+(i/11)*pw,y:pad.top+ph*(1-v/maxV)}));
  const grad=ctx.createLinearGradient(0,pad.top,0,pad.top+ph);grad.addColorStop(0,'rgba(139,99,64,0.18)');grad.addColorStop(1,'rgba(139,99,64,0.01)');
  ctx.beginPath();ctx.moveTo(pts[0].x,pad.top+ph);pts.forEach(p=>ctx.lineTo(p.x,p.y));ctx.lineTo(pts[pts.length-1].x,pad.top+ph);ctx.closePath();ctx.fillStyle=grad;ctx.fill();
  ctx.beginPath();pts.forEach((p,i)=>i===0?ctx.moveTo(p.x,p.y):ctx.lineTo(p.x,p.y));ctx.strokeStyle='#8b6340';ctx.lineWidth=2;ctx.lineJoin='round';ctx.stroke();
  pts.forEach((p,i)=>{const isCur=i===curMo;ctx.beginPath();ctx.arc(p.x,p.y,isCur?4.5:3,0,Math.PI*2);ctx.fillStyle=isCur?'#8b6340':'#d4a96a';ctx.fill();if(isCur){ctx.strokeStyle='#fff';ctx.lineWidth=1.5;ctx.stroke();}ctx.fillStyle='rgba(168,148,122,0.8)';ctx.font='8px DM Mono,monospace';ctx.textAlign='center';ctx.fillText(ML[i],p.x,H-6);});
}
function applyChartLayout(){const isMobile=window.innerWidth<640;document.getElementById('charts-carousel').classList.toggle('active',isMobile);document.getElementById('chart-cdots').style.display=isMobile?'flex':'none';document.getElementById('charts-grid').classList.toggle('active',!isMobile);}
window.addEventListener('resize',applyChartLayout);
function onChartCarouselScroll(){const el=document.getElementById('charts-carousel');const idx=Math.round(el.scrollLeft/(el.clientWidth||el.scrollWidth));document.querySelectorAll('.cdot').forEach((d,i)=>d.classList.toggle('on',i===idx));}

/* CHRONOLUNA LUNAR ENGINE */
const LUNAR={
  CNY:{1990:'1990-01-27',1991:'1991-02-15',1992:'1992-02-04',1993:'1993-01-23',1994:'1994-02-10',1995:'1995-01-31',1996:'1996-02-19',1997:'1997-02-07',1998:'1998-01-28',1999:'1999-02-16',2000:'2000-02-05',2001:'2001-01-24',2002:'2002-02-12',2003:'2003-02-01',2004:'2004-01-22',2005:'2005-02-09',2006:'2006-01-29',2007:'2007-02-18',2008:'2008-02-07',2009:'2009-01-26',2010:'2010-02-14',2011:'2011-02-03',2012:'2012-01-23',2013:'2013-02-10',2014:'2014-01-31',2015:'2015-02-19',2016:'2016-02-08',2017:'2017-01-28',2018:'2018-02-16',2019:'2019-02-05',2020:'2020-01-25',2021:'2021-02-12',2022:'2022-02-01',2023:'2023-01-22',2024:'2024-02-10',2025:'2025-01-29',2026:'2026-02-17',2027:'2027-02-06',2028:'2028-01-26',2029:'2029-02-13',2030:'2030-02-03',2031:'2031-01-23',2032:'2032-02-11',2033:'2033-01-31',2034:'2034-02-19',2035:'2035-02-08'},
  MONTHS:{1990:[30,29,30,29,30,29,30,29,30,29,29,30,5,29],2000:[30,29,30,29,30,29,30,29,30,30,29,30,8,29],2001:[29,30,29,30,29,30,29,30,29,30,29,30,0,0],2002:[30,29,30,30,29,30,29,30,29,30,29,30,4,29],2003:[29,30,29,30,30,29,30,29,30,29,30,29,2,29],2004:[30,29,30,29,30,29,30,29,30,30,29,30,0,0],2005:[29,30,29,30,29,30,29,30,29,30,30,29,7,29],2006:[30,29,30,29,30,29,30,29,30,29,30,29,7,29],2007:[29,30,29,30,29,30,30,29,30,29,30,29,0,0],2008:[30,29,30,29,30,29,30,29,30,30,29,30,5,29],2009:[29,30,29,30,29,30,29,30,29,30,30,29,5,29],2010:[30,29,30,29,30,30,29,30,29,30,29,30,6,29],2011:[29,30,29,30,29,30,30,29,30,29,30,29,0,0],2012:[30,29,30,29,30,29,30,29,30,29,30,30,4,29],2013:[29,30,29,30,29,30,29,30,29,30,29,29,11,29],2014:[30,29,30,29,30,29,30,30,29,30,29,30,9,29],2015:[29,30,29,30,29,30,29,30,30,29,30,29,6,29],2016:[30,29,30,29,30,29,30,29,30,30,29,30,0,0],2017:[29,30,29,30,29,30,29,30,29,30,30,29,6,29],2018:[30,29,30,29,30,29,30,29,30,29,30,29,0,0],2019:[30,30,29,30,29,30,29,30,29,30,29,30,0,0],2020:[30,29,30,29,30,29,30,30,29,30,29,30,4,29],2021:[29,30,29,30,29,30,29,30,30,29,30,29,0,0],2022:[30,29,30,29,30,29,30,29,30,30,29,30,0,0],2023:[29,30,29,30,29,30,30,29,30,29,30,29,2,29],2024:[30,29,30,29,30,29,30,30,29,30,29,30,0,0],2025:[30,29,30,29,29,30,29,30,29,30,30,29,6,29],2026:[29,30,30,29,30,30,29,30,29,30,29,30,0,0],2027:[30,29,30,29,30,29,30,30,29,30,29,30,5,29],2028:[29,30,29,30,29,30,29,30,29,30,30,29,0,0],2029:[30,29,30,29,30,29,30,29,30,30,29,30,0,0],2030:[29,30,29,30,29,30,29,30,29,30,29,30,3,30],2031:[30,29,30,30,29,30,29,30,29,30,29,30,3,29],2032:[29,30,29,30,30,29,30,29,30,29,30,29,0,0],2033:[30,29,30,29,30,29,30,29,30,30,29,30,11,29],2034:[29,30,29,30,29,30,29,30,29,30,30,29,0,0],2035:[30,30,29,30,29,30,29,30,29,30,29,30,6,29]},
  monthNames:['正月','二月','三月','四月','五月','六月','七月','八月','九月','十月','冬月','腊月'],
  dayNames:['初一','初二','初三','初四','初五','初六','初七','初八','初九','初十','十一','十二','十三','十四','十五','十六','十七','十八','十九','二十','廿一','廿二','廿三','廿四','廿五','廿六','廿七','廿八','廿九','三十'],
  stems:['甲','乙','丙','丁','戊','己','庚','辛','壬','癸'],branches:['子','丑','寅','卯','辰','巳','午','未','申','酉','戌','亥'],zodiac:['鼠','牛','虎','兔','龙','蛇','马','羊','猴','鸡','狗','猪'],
  _sbYear(ly){const si=((ly-4)%10+10)%10;const bi=((ly-4)%12+12)%12;return this.stems[si]+this.branches[bi];},
  leapMonth(ly){return(this.MONTHS[ly]||[])[12]||0;},leapDays(ly){return(this.MONTHS[ly]||[])[13]||0;},monthDays(ly,m){return(this.MONTHS[ly]||[])[m-1]||29;},
  _noon(y,m,d){return Date.UTC(y,m-1,d,12,0,0);},
  solar2lunar(sy,sm,sd){
    const targetMs=this._noon(sy,sm,sd);let ly=sy;
    if(!this.CNY[ly])throw new Error(`No data for ${ly}`);
    const[cny0y,cny0m,cny0d]=this.CNY[ly].split('-').map(Number);
    if(targetMs<this._noon(cny0y,cny0m,cny0d))ly--;
    if(!this.CNY[ly]||!this.MONTHS[ly])throw new Error(`No lunar data for year ${ly}`);
    const[cnyY,cnyM,cnyD]=this.CNY[ly].split('-').map(Number);let cursorMs=this._noon(cnyY,cnyM,cnyD);
    const mdata=this.MONTHS[ly];const leapM=mdata[12];const leapSz=mdata[13];const MS=86400000;
    for(let mi=0;mi<12;mi++){
      const mdays=mdata[mi];const mEndMs=cursorMs+mdays*MS;
      if(targetMs>=cursorMs&&targetMs<mEndMs){const day=Math.round((targetMs-cursorMs)/MS)+1;return{lYear:ly,lMonth:mi+1,lDay:day,isLeap:false,sbYear:this._sbYear(ly),zodiac:this.zodiac[((ly-4)%12+12)%12],monthName:this.monthNames[mi],dayName:this.dayNames[day-1]||`${day}日`};}
      cursorMs=mEndMs;
      if(leapM===mi+1&&leapSz>0){const leapEndMs=cursorMs+leapSz*MS;if(targetMs>=cursorMs&&targetMs<leapEndMs){const day=Math.round((targetMs-cursorMs)/MS)+1;return{lYear:ly,lMonth:mi+1,lDay:day,isLeap:true,sbYear:this._sbYear(ly),zodiac:this.zodiac[((ly-4)%12+12)%12],monthName:'闰'+this.monthNames[mi],dayName:this.dayNames[day-1]||`${day}日`};}cursorMs=leapEndMs;}
    }
    throw new Error(`Date ${sy}-${sm}-${sd} not found`);
  },
  lunar2solar(ly,lm,ld,isLeap){
    if(!this.CNY[ly]||!this.MONTHS[ly])throw new Error(`No data for ${ly}`);
    const mdata=this.MONTHS[ly];const leapM=mdata[12];const leapSz=mdata[13];const MS=86400000;
    const[cnyY,cnyM,cnyD]=this.CNY[ly].split('-').map(Number);let ms=this._noon(cnyY,cnyM,cnyD);
    for(let mi=0;mi<lm-1;mi++){ms+=mdata[mi]*MS;if(leapM===mi+1&&leapSz>0)ms+=leapSz*MS;}
    if(isLeap&&leapM===lm)ms+=mdata[lm-1]*MS;ms+=(ld-1)*MS;
    const tmp=new Date(ms);return new Date(tmp.getUTCFullYear(),tmp.getUTCMonth(),tmp.getUTCDate());
  }
};

/* CHRONOLUNA STATE */
let events=JSON.parse(localStorage.getItem('cl_events')||'[]');
let clSettings=JSON.parse(localStorage.getItem('cl_settings')||'{"dark":false,"notifications":false,"showLunar":true}');
let currentFilter='all';let editingId=null;let detailId=null;
let selectedCat='🎂';let selectedRepeat='none';let selectedNotifs=new Set();
let calMode='gregorian';let lunarGregorianDate=null;
let clSbClient=null;let clSbConfig=JSON.parse(localStorage.getItem('cl_supabase')||'null');

async function saveEvents(){
  localStorage.setItem('cl_events',JSON.stringify(events));
  if(!clSbClient)return;
  try{const rows=events.map(ev=>({id:ev.id,name:ev.name,date:ev.date,category:ev.category||'⭐',repeat:ev.repeat||'none',cal_type:ev.calType||'gregorian',lunar_meta:ev.lunarMeta?JSON.stringify(ev.lunarMeta):null,notes:ev.notes||null,notifs:JSON.stringify(ev.notifs||[]),color:ev.color||'#c9a84c',updated_at:new Date().toISOString()}));await clSbClient.from('events').upsert(rows,{onConflict:'id'});}catch(e){showToast('⚠️ Saved locally. Supabase: '+e.message);}
}
function saveClSettings(){localStorage.setItem('cl_settings',JSON.stringify(clSettings));}

function getNextOccurrence(ev){
  const now=new Date();now.setHours(0,0,0,0);
  if(ev.repeat==='none')return new Date(ev.date+'T00:00:00');
  if(ev.repeat==='daily')return new Date(now);
  if(ev.repeat==='yearly'){
    if(ev.calType==='chinese'&&ev.lunarMeta){const{lMonth,lDay,isLeap}=ev.lunarMeta;for(let go=0;go<=1;go++){const ty=now.getFullYear()+go;for(let lo=-1;lo<=1;lo++){const tl=ty+lo;if(!LUNAR.CNY[tl])continue;try{const g=LUNAR.lunar2solar(tl,lMonth,lDay,isLeap);g.setHours(0,0,0,0);if(g>=now)return g;}catch(e){}}}return new Date(ev.date+'T00:00:00');}
    const[,origM,origD]=ev.date.split('-').map(Number);let cy=now.getFullYear();let c=new Date(cy,origM-1,origD);c.setHours(0,0,0,0);if(c<now){cy++;c=new Date(cy,origM-1,origD);c.setHours(0,0,0,0);}return c;
  }
  if(ev.repeat==='monthly'){const[,origM,origD]=ev.date.split('-').map(Number);const ny=now.getFullYear();const nm=now.getMonth();for(let offset=0;offset<=1;offset++){const d=new Date(ny,nm+offset,origD);d.setHours(0,0,0,0);if(d.getDate()!==origD)continue;if(d>=now)return d;}for(let offset=2;offset<=13;offset++){const d=new Date(ny,nm+offset,origD);d.setHours(0,0,0,0);if(d.getDate()===origD&&d>=now)return d;}return new Date(ev.date+'T00:00:00');}
  return new Date(ev.date+'T00:00:00');
}
function daysUntil(ev){const now=new Date();now.setHours(0,0,0,0);return Math.round((getNextOccurrence(ev)-now)/86400000);}
function liveCountdown(ev){const now=new Date();const t=getNextOccurrence(ev);t.setHours(0,0,0,0);let diff=Math.max(0,t-now);const days=Math.floor(diff/86400000);diff%=86400000;return{days,hours:Math.floor(diff/3600000),minutes:Math.floor((diff%3600000)/60000),seconds:Math.floor((diff%60000)/1000)};}
function lunarLabel(ev){try{const d=getNextOccurrence(ev);const l=LUNAR.solar2lunar(d.getFullYear(),d.getMonth()+1,d.getDate());return`农历 ${l.sbYear}年 ${l.monthName}${l.dayName}`;}catch(e){return '';}}
const CAT_COLORS={'🎂':'#e74c3c','💍':'#9b59b6','🏮':'#c0392b','🎯':'#e67e22','✈️':'#3a6ea5','🎓':'#27ae60','💼':'#7f8c8d','❤️':'#e91e63','🏆':'#f39c12','⭐':'#2c3e50'};
function formatDate(str){try{const[y,m,d]=str.split('-');return new Date(y,m-1,d).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'});}catch{return str;}}
function nextDateStr(ev){try{const d=getNextOccurrence(ev);if(!d||isNaN(d.getTime()))return ev.date;return`${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;}catch(e){return ev.date;}}
function getUpcoming(){return events.map(ev=>({ev,days:daysUntil(ev)})).filter(x=>x.days>=0).sort((a,b)=>a.days-b.days);}

function renderCarousel(){
  const track=document.getElementById('carousel-track');
  const upcoming=getUpcoming().slice(0,20);
  if(!upcoming.length){track.innerHTML='<div class="empty-carousel">No upcoming events. Add one! 🏮</div>';document.getElementById('cl-next-banner').classList.add('hidden');return;}
  document.getElementById('banner-name').textContent=upcoming[0].ev.name;
  document.getElementById('banner-days').textContent=upcoming[0].days;
  document.getElementById('cl-next-banner').classList.remove('hidden');
  track.innerHTML=upcoming.map(({ev,days})=>{const cd=liveCountdown(ev);const color=CAT_COLORS[ev.category]||'#c9a84c';const isToday=days===0;const lunar=clSettings.showLunar?`<div class="card-lunar">${lunarLabel(ev)}</div>`:'';
    return`<div class="event-card${isToday?' card-celebrated':''}" style="--cat-color:${color}" data-id="${ev.id}" onclick="openDetail('${ev.id}')">
      <span class="card-cat-icon">${ev.category}</span><div class="card-name">${ev.name}</div>${lunar}
      <div class="card-countdown">
        <div class="countdown-unit"><span class="countdown-num">${cd.days}</span><span class="countdown-label">Days</span></div>
        <div class="countdown-unit"><span class="countdown-num">${String(cd.hours).padStart(2,'0')}</span><span class="countdown-label">Hrs</span></div>
        <div class="countdown-unit"><span class="countdown-num">${String(cd.minutes).padStart(2,'0')}</span><span class="countdown-label">Min</span></div>
        <div class="countdown-unit"><span class="countdown-num">${String(cd.seconds).padStart(2,'0')}</span><span class="countdown-label">Sec</span></div>
      </div>
      <div class="card-footer"><span class="card-date">${formatDate(nextDateStr(ev))}</span><div class="card-actions"><button class="card-action-btn" onclick="event.stopPropagation();openEdit('${ev.id}')">✏️</button></div></div>
      ${ev.repeat!=='none'?`<div class="card-repeat" style="position:absolute;top:12px;right:12px;font-size:.6rem">🔄 ${ev.repeat}</div>`:''}
    </div>`;
  }).join('');
}
function clRenderList(){
  const list=document.getElementById('event-list');
  let filtered=currentFilter==='all'?events:events.filter(e=>e.category===currentFilter);
  const sorted=filtered.map(ev=>({ev,days:daysUntil(ev)})).sort((a,b)=>{if(a.days>=0&&b.days>=0)return a.days-b.days;if(a.days<0&&b.days<0)return b.days-a.days;return a.days>=0?-1:1;});
  if(!sorted.length){list.innerHTML='<div style="text-align:center;color:var(--cl-muted);padding:30px 0;font-size:.9rem;font-family:DM Sans,sans-serif">No events in this category</div>';return;}
  list.innerHTML=sorted.map(({ev,days})=>`<div class="event-list-item" onclick="openDetail('${ev.id}')"><div class="list-icon">${ev.category}</div><div class="list-info"><div class="list-name">${ev.name}</div><div class="list-date">${formatDate(nextDateStr(ev))}${ev.repeat!=='none'?' · 🔄 '+ev.repeat:''}</div></div><div class="list-days ${days<0?'past':''}">${days===0?'Today!':days>0?days+'d':Math.abs(days)+'d ago'}</div></div>`).join('');
}
function renderAll(){renderCarousel();clRenderList();}

setInterval(()=>{
  document.querySelectorAll('.event-card').forEach(card=>{const ev=events.find(e=>e.id===card.dataset.id);if(!ev)return;const cd=liveCountdown(ev);const nums=card.querySelectorAll('.countdown-num');if(nums[0])nums[0].textContent=cd.days;if(nums[1])nums[1].textContent=String(cd.hours).padStart(2,'0');if(nums[2])nums[2].textContent=String(cd.minutes).padStart(2,'0');if(nums[3])nums[3].textContent=String(cd.seconds).padStart(2,'0');});
  if(detailId)updateDetailCountdown();
  const upcoming=getUpcoming();if(upcoming.length)document.getElementById('banner-days').textContent=upcoming[0].days;
},1000);

function openClModal(id){document.getElementById(id).classList.add('open');}
function closeClModal(id){document.getElementById(id).classList.remove('open');}
function openAdd(){editingId=null;document.getElementById('modal-title-text').textContent='New Event';document.getElementById('ev-name').value='';document.getElementById('ev-date').value='';document.getElementById('ev-notes').value='';document.getElementById('lunar-display').textContent='Select a date to see its lunar equivalent';document.getElementById('delete-btn').style.display='none';selectedCat='🎂';selectedRepeat='none';selectedNotifs=new Set(['1']);calMode='gregorian';lunarGregorianDate=null;switchCalMode('gregorian');updateCatUI();updateRepeatUI();updateNotifUI();openClModal('add-overlay');}
function openEdit(id){const ev=events.find(e=>e.id===id);if(!ev)return;closeClModal('detail-overlay');editingId=id;document.getElementById('modal-title-text').textContent='Edit Event';document.getElementById('ev-name').value=ev.name;document.getElementById('ev-notes').value=ev.notes||'';document.getElementById('delete-btn').style.display='block';selectedCat=ev.category;selectedRepeat=ev.repeat;selectedNotifs=new Set(ev.notifs||[]);const mode=ev.calType==='chinese'?'chinese':'gregorian';calMode=mode;lunarGregorianDate=null;switchCalMode(mode);if(mode==='gregorian'){document.getElementById('ev-date').value=ev.date;updateLunarDisplay(ev.date);}else{buildLunarYearSelect(ev.lunarMeta?.lYear);buildLunarMonthSelect(ev.lunarMeta?.lMonth,ev.lunarMeta?.isLeap);buildLunarDaySelect(ev.lunarMeta?.lDay);lunarGregorianDate=ev.date;}updateCatUI();updateRepeatUI();updateNotifUI();openClModal('add-overlay');}
function openDetail(id){detailId=id;const ev=events.find(e=>e.id===id);if(!ev)return;document.getElementById('detail-icon').textContent=ev.category;document.getElementById('detail-name').textContent=ev.name;document.getElementById('detail-lunar-label').textContent=clSettings.showLunar?lunarLabel(ev):'';const nextOcc=nextDateStr(ev);const repeatLabel=ev.repeat!=='none'?` · Repeats ${ev.repeat}`:'';document.getElementById('detail-date-str').textContent=formatDate(nextOcc)+repeatLabel;const ns=document.getElementById('detail-notes-section');if(ev.notes){document.getElementById('detail-notes').textContent=ev.notes;ns.style.display='block';}else{ns.style.display='none';}updateDetailCountdown();if(daysUntil(ev)===0)launchConfetti();openClModal('detail-overlay');}
function updateDetailCountdown(){const ev=events.find(e=>e.id===detailId);if(!ev)return;const cd=liveCountdown(ev);document.getElementById('detail-countdown-grid').innerHTML=`<div class="detail-unit"><span class="detail-num">${cd.days}</span><span class="detail-label">Days</span></div><div class="detail-unit"><span class="detail-num">${String(cd.hours).padStart(2,'0')}</span><span class="detail-label">Hours</span></div><div class="detail-unit"><span class="detail-num">${String(cd.minutes).padStart(2,'0')}</span><span class="detail-label">Minutes</span></div><div class="detail-unit"><span class="detail-num">${String(cd.seconds).padStart(2,'0')}</span><span class="detail-label">Seconds</span></div>`;}
function updateCatUI(){document.querySelectorAll('.cat-btn').forEach(b=>b.classList.toggle('selected',b.dataset.cat===selectedCat));}
function updateRepeatUI(){document.querySelectorAll('.cl-toggle-btn').forEach(b=>{if(b.dataset.repeat!==undefined)b.classList.toggle('active',b.dataset.repeat===selectedRepeat);});}
function updateNotifUI(){document.querySelectorAll('.notif-chip').forEach(chip=>{const v=chip.querySelector('input').value;chip.classList.toggle('selected',selectedNotifs.has(v));});}
function updateLunarDisplay(dateStr){if(!dateStr)return;try{const[y,m,d]=dateStr.split('-').map(Number);const l=LUNAR.solar2lunar(y,m,d);document.getElementById('lunar-display').textContent=`农历 ${l.sbYear}年 ${l.monthName}${l.dayName}（${l.lYear}年${l.isLeap?'闰':''}${l.lMonth}月${l.lDay}日）`;}catch(e){document.getElementById('lunar-display').textContent='无法转换日期';}}
async function saveEvent(){
  const name=document.getElementById('ev-name').value.trim();const notes=document.getElementById('ev-notes').value.trim();
  let date,lunarMeta=null;
  if(calMode==='gregorian'){date=document.getElementById('ev-date').value;if(!date){showToast('Please select a date.');return;}}
  else{if(!lunarGregorianDate){showToast('Please complete the lunar date.');return;}date=lunarGregorianDate;const ly=parseInt(document.getElementById('ln-year').value);const lm=parseInt(document.getElementById('ln-month').value);const ld=parseInt(document.getElementById('ln-day').value);const isLeap=document.getElementById('ln-leap').checked;lunarMeta={lYear:ly,lMonth:lm,lDay:ld,isLeap};}
  if(!name){showToast('Please enter an event name.');return;}
  const ev={id:editingId||'ev_'+Date.now(),name,date,notes,calType:calMode,lunarMeta,category:selectedCat,repeat:selectedRepeat,notifs:[...selectedNotifs],color:CAT_COLORS[selectedCat]||'#c9a84c'};
  if(editingId){events=events.map(e=>e.id===editingId?ev:e);}else{events.push(ev);}
  await saveEvents();closeClModal('add-overlay');renderAll();renderDashEventBanner();showToast(editingId?'Event updated! ✓':'Event added! 🎉');scheduleNotifications(ev);
}
async function deleteEvent(){if(!editingId)return;if(!confirm('Delete this event?'))return;const idToDel=editingId;events=events.filter(e=>e.id!==idToDel);localStorage.setItem('cl_events',JSON.stringify(events));if(clSbClient){try{await clSbClient.from('events').delete().eq('id',idToDel);}catch(e){showToast('⚠️ Local deleted. Supabase: '+e.message);}}closeClModal('add-overlay');renderAll();renderDashEventBanner();showToast('Event deleted.');}
function scheduleNotifications(ev){if(!clSettings.notifications||!ev.notifs.length)return;if(!('Notification'in window))return;Notification.requestPermission().then(p=>{if(p!=='granted')return;ev.notifs.forEach(ds=>{const d=parseInt(ds);const target=getNextOccurrence(ev);target.setDate(target.getDate()-d);const delay=target-new Date();if(delay>0)setTimeout(()=>new Notification('Labdeck 🏮',{body:d===0?`${ev.name} is today!`:`${ev.name} is in ${d} day${d>1?'s':''}!`}),delay);});});}
function shareLink(id){const url=`${location.href}#event=${id}`;navigator.clipboard.writeText(url).then(()=>showToast('Link copied!'));}
function launchConfetti(){const container=document.getElementById('confetti-container');const colors=['#c0392b','#c9a84c','#27ae60','#3a6ea5','#9b59b6','#f39c12'];container.innerHTML='';for(let i=0;i<80;i++){const p=document.createElement('div');p.className='confetti-piece';p.style.cssText=`left:${Math.random()*100}%;background:${colors[Math.floor(Math.random()*colors.length)]};width:${6+Math.random()*8}px;height:${6+Math.random()*8}px;animation-delay:${Math.random()*2}s;animation-duration:${2+Math.random()*2}s;border-radius:${Math.random()>.5?'50%':'2px'}`;container.appendChild(p);}setTimeout(()=>container.innerHTML='',5000);}
function showToast(msg){const t=document.getElementById('cl-toast');t.textContent=msg;t.classList.add('show');setTimeout(()=>t.classList.remove('show'),2800);}
function applyTheme(){document.documentElement.setAttribute('data-theme',clSettings.dark?'dark':'light');const tb=document.getElementById('cl-theme-btn');if(tb)tb.textContent=clSettings.dark?'☀️':'🌙';document.getElementById('dark-toggle').classList.toggle('on',clSettings.dark);document.getElementById('notif-toggle').classList.toggle('on',clSettings.notifications);document.getElementById('lunar-toggle').classList.toggle('on',clSettings.showLunar);}
function exportJSON(){const blob=new Blob([JSON.stringify(events,null,2)],{type:'application/json'});const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='chronoluna-events.json';a.click();}
function exportICS(){let ics='BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//Labdeck//EN\r\n';events.forEach(ev=>{const[y,m,d]=ev.date.split('-');ics+=`BEGIN:VEVENT\r\nSUMMARY:${ev.name}\r\nDTSTART;VALUE=DATE:${y}${m}${d}\r\nDTEND;VALUE=DATE:${y}${m}${d}\r\n`;if(ev.repeat==='yearly')ics+='RRULE:FREQ=YEARLY\r\n';if(ev.notes)ics+=`DESCRIPTION:${ev.notes}\r\n`;ics+=`UID:${ev.id}@labdeck\r\nEND:VEVENT\r\n`;});ics+='END:VCALENDAR';const blob=new Blob([ics],{type:'text/calendar'});const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='labdeck-events.ics';a.click();}

document.getElementById('add-btn').addEventListener('click',openAdd);
document.getElementById('cancel-btn').addEventListener('click',()=>closeClModal('add-overlay'));
document.getElementById('save-btn').addEventListener('click',saveEvent);
document.getElementById('delete-btn').addEventListener('click',deleteEvent);
document.getElementById('detail-close-btn').addEventListener('click',()=>{detailId=null;closeClModal('detail-overlay');});
document.getElementById('cl-settings-btn').addEventListener('click',()=>openClModal('settings-overlay'));
document.getElementById('settings-close-btn').addEventListener('click',()=>closeClModal('settings-overlay'));
document.getElementById('cl-next-banner').addEventListener('click',()=>{document.getElementById('carousel-track').scrollTo({left:0,behavior:'smooth'});});
document.getElementById('share-link-btn').addEventListener('click',()=>shareLink(detailId));
document.getElementById('share-img-btn').addEventListener('click',()=>showToast('Screenshot to share! 📸'));
document.getElementById('edit-from-detail-btn').addEventListener('click',()=>openEdit(detailId));
document.getElementById('cl-theme-btn').addEventListener('click',()=>{clSettings.dark=!clSettings.dark;applyTheme();saveClSettings();renderAll();});
document.getElementById('dark-toggle').addEventListener('click',()=>{clSettings.dark=!clSettings.dark;applyTheme();saveClSettings();renderAll();});
document.getElementById('notif-toggle').addEventListener('click',()=>{clSettings.notifications=!clSettings.notifications;if(clSettings.notifications)Notification.requestPermission();applyTheme();saveClSettings();});
document.getElementById('lunar-toggle').addEventListener('click',()=>{clSettings.showLunar=!clSettings.showLunar;applyTheme();saveClSettings();renderAll();});
document.getElementById('export-json-btn').addEventListener('click',exportJSON);
document.getElementById('export-ics-btn').addEventListener('click',exportICS);
document.querySelectorAll('.cat-btn').forEach(btn=>btn.addEventListener('click',()=>{selectedCat=btn.dataset.cat;updateCatUI();}));
document.querySelectorAll('.cl-toggle-btn').forEach(btn=>btn.addEventListener('click',()=>{if(btn.dataset.repeat!==undefined){selectedRepeat=btn.dataset.repeat;updateRepeatUI();}}));
document.querySelectorAll('.notif-chip').forEach(chip=>chip.addEventListener('click',()=>{const v=chip.querySelector('input').value;if(selectedNotifs.has(v))selectedNotifs.delete(v);else selectedNotifs.add(v);updateNotifUI();}));
document.getElementById('ev-date').addEventListener('change',e=>updateLunarDisplay(e.target.value));
document.querySelectorAll('#calmode-toggle .cl-toggle-btn').forEach(btn=>btn.addEventListener('click',()=>{calMode=btn.dataset.calmode;document.querySelectorAll('#calmode-toggle .cl-toggle-btn').forEach(b=>b.classList.toggle('active',b===btn));document.getElementById('greg-picker-row').style.display=calMode==='gregorian'?'block':'none';document.getElementById('lunar-picker-row').style.display=calMode==='chinese'?'block':'none';if(calMode==='chinese')buildLunarYearSelect();}));
document.getElementById('ln-year').addEventListener('change',buildLunarMonthSelect);
document.getElementById('ln-month').addEventListener('change',buildLunarDaySelect);
document.getElementById('ln-day').addEventListener('change',updateLunarResolved);
document.getElementById('ln-leap').addEventListener('change',()=>{document.getElementById('ln-leap-label').classList.toggle('selected',document.getElementById('ln-leap').checked);buildLunarDaySelect();});
document.querySelectorAll('.filter-tab').forEach(tab=>tab.addEventListener('click',()=>{currentFilter=tab.dataset.filter;document.querySelectorAll('.filter-tab').forEach(t=>t.classList.remove('active'));tab.classList.add('active');clRenderList();}));
document.querySelectorAll('.cl-overlay').forEach(ov=>ov.addEventListener('click',e=>{if(e.target===ov){detailId=null;ov.classList.remove('open');}}));

function switchCalMode(mode){calMode=mode;document.querySelectorAll('#calmode-toggle .cl-toggle-btn').forEach(b=>b.classList.toggle('active',b.dataset.calmode===mode));document.getElementById('greg-picker-row').style.display=mode==='gregorian'?'block':'none';document.getElementById('lunar-picker-row').style.display=mode==='chinese'?'block':'none';if(mode==='chinese')buildLunarYearSelect();}
function buildLunarYearSelect(selectYear){const sel=document.getElementById('ln-year');const target=selectYear||new Date().getFullYear();sel.innerHTML='';Object.keys(LUNAR.CNY).map(Number).filter(y=>y>=2000&&y<=2035).forEach(y=>{const opt=document.createElement('option');opt.value=y;opt.textContent=`${y} ${LUNAR._sbYear(y)}年`;if(y===target)opt.selected=true;sel.appendChild(opt);});buildLunarMonthSelect();}
function buildLunarMonthSelect(selectMonth,selectLeap){const y=parseInt(document.getElementById('ln-year').value);const leapM=LUNAR.leapMonth(y);const sel=document.getElementById('ln-month');sel.innerHTML='';for(let m=1;m<=12;m++){const opt=document.createElement('option');opt.value=m;opt.textContent=LUNAR.monthNames[m-1];if(m===(selectMonth||1))opt.selected=true;sel.appendChild(opt);}const ll=document.getElementById('ln-leap-label'),lc=document.getElementById('ln-leap'),cm=selectMonth||1;if(leapM>0){ll.style.display='flex';lc.disabled=(cm!==leapM);if(selectLeap!==undefined){lc.checked=!!selectLeap&&cm===leapM;}else{lc.checked=false;}ll.classList.toggle('selected',lc.checked);}else{ll.style.display='none';lc.checked=false;}buildLunarDaySelect();}
function buildLunarDaySelect(selectDay){const y=parseInt(document.getElementById('ln-year').value);const m=parseInt(document.getElementById('ln-month').value);const isLeap=document.getElementById('ln-leap').checked;const leapM=LUNAR.leapMonth(y);const lc=document.getElementById('ln-leap');const ll=document.getElementById('ln-leap-label');if(leapM>0){lc.disabled=(m!==leapM);if(m!==leapM){lc.checked=false;ll.classList.remove('selected');}}const days=(isLeap&&leapM===m)?LUNAR.leapDays(y):LUNAR.monthDays(y,m);const sel=document.getElementById('ln-day');const current=selectDay||Math.min(parseInt(sel.value)||1,days);sel.innerHTML='';for(let d=1;d<=days;d++){const opt=document.createElement('option');opt.value=d;opt.textContent=LUNAR.dayNames[d-1]||`${d}日`;if(d===current)opt.selected=true;sel.appendChild(opt);}updateLunarResolved();}
function updateLunarResolved(){const y=parseInt(document.getElementById('ln-year').value);const m=parseInt(document.getElementById('ln-month').value);const d=parseInt(document.getElementById('ln-day').value);const isLeap=document.getElementById('ln-leap').checked;const resultEl=document.getElementById('lunar-greg-result');if(!y||!m||!d)return;try{const greg=LUNAR.lunar2solar(y,m,d,isLeap);const gy=greg.getFullYear();const gm=greg.getMonth()+1;const gd=greg.getDate();lunarGregorianDate=`${gy}-${String(gm).padStart(2,'0')}-${String(gd).padStart(2,'0')}`;resultEl.textContent=`农历 ${LUNAR._sbYear(y)}年 ${isLeap?'闰':''}${LUNAR.monthNames[m-1]}${LUNAR.dayNames[d-1]||d+'日'}  →  ${gy}年${gm}月${gd}日`;resultEl.style.color='var(--jade)';}catch(e){resultEl.textContent='无效日期 — '+e.message;resultEl.style.color='var(--vermillion)';lunarGregorianDate=null;}}

/* CL SUPABASE */
function clSbSetStatus(type,msg){const el=document.getElementById('sb-status');el.className='sb-status '+type;document.getElementById('sb-status-msg').textContent=msg;}
async function initClSupabase(url,key){const{createClient}=supabase;return createClient(url.trim(),key.trim());}
async function testAndConnectCl(url,key){if(!url||!key){clSbSetStatus('error','Please fill in both fields.');return false;}if(!url.startsWith('https://')){clSbSetStatus('error','URL must start with https://');return false;}clSbSetStatus('loading','Connecting…');document.getElementById('sb-connect-btn').disabled=true;try{const client=await initClSupabase(url,key);const{error}=await client.from('events').select('id').limit(1);if(error){const msg=error.message||'';if(msg.includes('Invalid API key')||msg.includes('JWT'))throw new Error('Invalid API key.');}clSbClient=client;clSbConfig={url:url.trim(),key:key.trim()};localStorage.setItem('cl_supabase',JSON.stringify(clSbConfig));clSbSetStatus('success','Connected!');updateSbIndicator(true,url);updateSbSettingsCard();return true;}catch(err){clSbSetStatus('error',err.message||'Connection failed.');document.getElementById('sb-connect-btn').disabled=false;return false;}}
async function loadEventsFromSupabase(){if(!clSbClient)return;try{const{data,error}=await clSbClient.from('events').select('*');if(error)throw error;events=(data||[]).map(rowToEvent);localStorage.setItem('cl_events',JSON.stringify(events));renderAll();renderDashEventBanner();showToast(`Loaded ${events.length} event${events.length!==1?'s':''} ☁️`);}catch(e){console.warn('CL load failed:',e.message);}}
function disconnectSupabase(){if(!confirm('Disconnect Supabase?'))return;clSbClient=null;clSbConfig=null;localStorage.removeItem('cl_supabase');events=JSON.parse(localStorage.getItem('cl_events')||'[]');updateSbIndicator(false);updateSbSettingsCard();renderAll();renderDashEventBanner();showToast('Disconnected.');}
function updateSbIndicator(connected,url){const ind=document.getElementById('sb-indicator');const lbl=document.getElementById('sb-indicator-label');if(connected){ind.className='sb-indicator connected';try{const ref=new URL(url).hostname.split('.')[0];lbl.textContent=ref;}catch{lbl.textContent='Synced';}}else{ind.className='sb-indicator local';lbl.textContent='Local';}}
function updateSbSettingsCard(){const sl=document.getElementById('sb-settings-status-label'),ul=document.getElementById('sb-settings-url'),db=document.getElementById('sb-disconnect-btn'),rb=document.getElementById('sb-reconfigure-btn'),hint=document.getElementById('sb-storage-hint');if(clSbConfig){sl.textContent='✅ Connected to Supabase';sl.style.color='var(--jade)';ul.textContent=clSbConfig.url;db.style.display='inline-flex';rb.textContent='✏️ Edit Connection';if(hint)hint.innerHTML='☁️ Data synced to Supabase.';}else{sl.textContent='○ Not connected';sl.style.color='var(--cl-muted)';ul.textContent='';db.style.display='none';rb.textContent='⚙️ Connect Supabase';if(hint)hint.innerHTML='📱 Data saved in this browser only.';}const tb=document.getElementById('sb-test-btn');if(tb)tb.style.display=clSbConfig?'inline-flex':'none';}
function rowToEvent(row){return{id:row.id,name:row.name,date:row.date,category:row.category||'⭐',repeat:row.repeat||'none',calType:row.cal_type||'gregorian',lunarMeta:row.lunar_meta?(typeof row.lunar_meta==='string'?JSON.parse(row.lunar_meta):row.lunar_meta):null,notes:row.notes||'',notifs:row.notifs?(typeof row.notifs==='string'?JSON.parse(row.notifs):row.notifs):[],color:row.color||'#c9a84c'};}
function showSupabaseModal(){document.getElementById('cl-supabase-overlay').classList.add('open');if(clSbConfig){document.getElementById('sb-url-input').value=clSbConfig.url;document.getElementById('sb-key-input').value=clSbConfig.key;}document.getElementById('sb-status').className='sb-status';document.getElementById('sb-connect-btn').disabled=false;document.getElementById('sb-connect-label').textContent='🔗 Connect & Sync';}
function hideSupabaseModal(){document.getElementById('cl-supabase-overlay').classList.remove('open');}
document.getElementById('sb-connect-btn').addEventListener('click',async()=>{const url=document.getElementById('sb-url-input').value.trim();const key=document.getElementById('sb-key-input').value.trim();const label=document.getElementById('sb-connect-label');label.textContent='Connecting…';const ok=await testAndConnectCl(url,key);if(ok){label.textContent='✅ Connected!';setTimeout(async()=>{hideSupabaseModal();closeClModal('settings-overlay');await loadEventsFromSupabase();},1000);}else{label.textContent='🔗 Connect & Sync';document.getElementById('sb-connect-btn').disabled=false;}});
document.getElementById('sb-local-btn').addEventListener('click',()=>{hideSupabaseModal();localStorage.setItem('cl_sb_skipped','1');});
document.getElementById('sb-eye-btn').addEventListener('click',()=>{const inp=document.getElementById('sb-key-input');const h=inp.type==='password';inp.type=h?'text':'password';document.getElementById('sb-eye-btn').textContent=h?'🙈':'👁';});
document.getElementById('sb-indicator').addEventListener('click',()=>{clSbConfig?openClModal('settings-overlay'):showSupabaseModal();});
document.getElementById('sb-reconfigure-btn').addEventListener('click',()=>{closeClModal('settings-overlay');showSupabaseModal();});
document.getElementById('sb-disconnect-btn').addEventListener('click',disconnectSupabase);
async function testSupabaseWrite(){const el=document.getElementById('sb-debug-log');if(el){el.textContent='';el.style.display='block';}if(!clSbClient){if(el)el.textContent='❌ Not connected.';return;}try{const{data,error}=await clSbClient.from('events').select('id').limit(1);if(error)throw error;if(el)el.textContent+=`✓ events OK — rows: ${data?data.length:0}\n`;}catch(e){if(el)el.textContent+='❌ events: '+e.message+'\n';}}
document.getElementById('sb-test-btn').addEventListener('click',testSupabaseWrite);

/* ════ HABITFORGE ENGINE ════ */
let hfCampaigns=[];let hfCheckins=[];let hfRewards=[];let hfTotalPts=0;let hfEditId=null;
let hfSb=null;

function hfInitWithClient(client){hfSb=client;hfLoadAll();}
function hfResetClient(){hfSb=null;hfCampaigns=[];hfCheckins=[];hfRewards=[];hfTotalPts=0;}

async function hfLoadAll(){
  if(!hfSb)return;
  try{
    const[rc,rci,rr,re,rs]=await Promise.all([
      hfSb.from('hf_campaigns').select('*').order('created_at',{ascending:false}),
      hfSb.from('hf_checkins').select('*').order('checked_date',{ascending:false}),
      hfSb.from('hf_rewards').select('*').order('created_at',{ascending:false}),
      hfSb.from('hf_earned').select('*'),
      hfSb.from('hf_settings').select('*').eq('id','user').single(),
    ]);
    hfCampaigns=rc.data||[];hfCheckins=rci.data||[];hfRewards=rr.data||[];
    const em={};(re.data||[]).forEach(row=>{(em[row.reward_id]=em[row.reward_id]||[]).push(row);});
    hfRewards.forEach(r=>r._earned=em[r.id]||[]);
    hfTotalPts=rs.data?.total_points||0;
    hfRenderAll();renderDashEventBanner();
  }catch(e){console.warn('HabitForge load error:',e.message);}
}
function hfRenderAll(){hfRenderDashboard();hfRenderCampaigns();hfRenderCheckin();hfRenderRewards();hfUpdatePts();}
function hfUpdatePts(){document.getElementById('hf-sb-pts').textContent=hfTotalPts.toLocaleString();document.getElementById('hf-st-pts').textContent=hfTotalPts.toLocaleString();}
function hfNav(v){document.querySelectorAll('.hf-view').forEach(el=>el.classList.remove('on'));document.querySelectorAll('.hf-nb').forEach(b=>b.classList.remove('on'));document.getElementById('hf-view-'+v).classList.add('on');document.querySelector(`.hf-nb[data-hv="${v}"]`).classList.add('on');}
function hfGetTier(s){if(s>=60)return{mult:5,label:'Mythic',cls:'mythic'};if(s>=30)return{mult:4,label:'Legend',cls:'legend'};if(s>=15)return{mult:3,label:'Unstoppable',cls:'unstoppable'};if(s>=8)return{mult:2,label:'On Fire',cls:'onfire'};if(s>=4)return{mult:1.5,label:'Building',cls:'building'};return{mult:1,label:'Starter',cls:'starter'};}
function hfTierPts(base,s){return Math.round(base*hfGetTier(s).mult);}
function hfDateStr(){const d=new Date();return`${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;}
function hfOffsetDate(days,from=null){let d;if(from){const[y,m,dd]=from.split('-').map(Number);d=new Date(y,m-1,dd);}else{d=new Date();}d.setDate(d.getDate()+days);return`${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;}
function hfIsDue(camp){if(!camp.is_active)return false;const today=hfDateStr();if(camp.start_date&&camp.start_date>today)return false;if(camp.end_date&&camp.end_date<today)return false;const dow=new Date().getDay();if(camp.frequency==='weekdays')return dow>=1&&dow<=5;if(camp.frequency==='weekends')return dow===0||dow===6;if(camp.frequency==='custom')return Array.isArray(camp.custom_days)&&camp.custom_days.includes(dow);return true;}
function hfCalcStreak(campaignId){const dates=hfCheckins.filter(ci=>ci.campaign_id===campaignId).map(ci=>ci.checked_date).sort((a,b)=>b.localeCompare(a));if(!dates.length)return 0;const today=hfDateStr(),yest=hfOffsetDate(-1);if(!dates.includes(today)&&!dates.includes(yest))return 0;let cur=dates.includes(today)?today:yest,streak=0,safety=0;while(safety++<400){if(dates.includes(cur)){streak++;cur=hfOffsetDate(-1,cur);}else break;if(cur<hfOffsetDate(-365))break;}return streak;}
function hfCalcProg(camp){const s=new Date(camp.start_date).getTime(),e=new Date(camp.end_date).getTime();return Math.min(100,Math.max(0,Math.round((Date.now()-s)/(e-s)*100)));}
function hfEsc(s){if(!s)return'';return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}

function hfRenderDashboard(){
  const today=hfDateStr(),active=hfCampaigns.filter(c=>c.is_active),todayCIs=hfCheckins.filter(c=>c.checked_date===today);
  let best=0;active.forEach(c=>{const s=hfCalcStreak(c.id);if(s>best)best=s;});
  document.getElementById('hf-st-active').textContent=active.length;
  document.getElementById('hf-st-streak').textContent=best+'🔥';
  document.getElementById('hf-st-ci').textContent=hfCheckins.length;
  const due=active.filter(c=>hfIsDue(c));const hc=document.getElementById('hf-dash-habits');
  if(!hfCampaigns.length){hc.innerHTML=`<div class="hf-first-run"><div class="hf-fr-glow"></div><div class="hf-fr-in"><div class="hf-fr-ico">⬡</div><div class="hf-fr-title">Start your first habit</div><p class="hf-fr-sub">Track any habit daily. Build streaks, earn multiplied points, unlock milestone rewards.</p><button class="hf-btn-green" onclick="hfNewCampaign()">+ Create your first campaign</button></div></div>`;}
  else if(!due.length){hc.innerHTML=`<div class="hf-empty">No habits due today ✅</div>`;}
  else{hc.innerHTML=due.map(c=>{const s=hfCalcStreak(c.id),tier=hfGetTier(s),pts=hfTierPts(c.points_per_checkin,s),done=todayCIs.some(ci=>ci.campaign_id===c.id);return`<div class="hf-hcard${done?' checked':''}" onclick="hfEditCampaign('${c.id}')"><div class="hf-hcard-top"><div class="hf-hcard-emo">${c.emoji||'📌'}</div><div class="hf-edit-hint">✏ edit</div></div><div class="hf-hcard-name">${hfEsc(c.name)}</div><div class="hf-hcard-streak">🔥 ${s} day streak &nbsp;<span class="hf-tbadge hf-t-${tier.cls}">${tier.label}</span></div><div class="hf-hcard-pts">+${pts} pts <span class="hf-pts-base">(${c.points_per_checkin}×${tier.mult})</span></div><button class="hf-hcard-btn${done?' done':''}" onclick="event.stopPropagation();${done?'':` hfCheckin('${c.id}')`}" ${done?'disabled':''}>${done?'✓ Done today':'Check in'}</button></div>`;}).join('');}
  const feed=document.getElementById('hf-dash-feed'),recent=hfCheckins.slice(0,10);
  feed.innerHTML=recent.length?recent.map(ci=>{const c=hfCampaigns.find(x=>x.id===ci.campaign_id);return`<div class="hf-feed-item"><span class="hf-feed-ico">${c?.emoji||'📌'}</span><span class="hf-feed-tx">Checked in <strong>${hfEsc(c?.name||'Unknown')}</strong></span><span class="hf-feed-dt">${ci.checked_date}</span></div>`;}).join(''):`<div class="hf-empty" style="border:none;padding:.5rem 0">No activity yet.</div>`;
}
function hfUpdateTierPreview(){const base=parseInt(document.getElementById('hf-c-pts').value)||10;const tiers=[{d:'1–3d',m:1},{d:'4–7d',m:1.5},{d:'8–14d',m:2},{d:'15–29d',m:3},{d:'30–59d',m:4},{d:'60d+',m:5}];document.getElementById('hf-tier-preview-grid').innerHTML=tiers.map(t=>`<div class="hf-tp-cell"><div class="hf-tp-days">${t.d}</div><div class="hf-tp-pts">${Math.round(base*t.m)}</div><div class="hf-tp-mult">×${t.m}</div></div>`).join('');}
function hfNewCampaign(){hfEditId=null;hfClearCampForm();document.getElementById('hf-cm-title').textContent='New Campaign';document.getElementById('hf-cm-save').textContent='Create Campaign';hfUpdateTierPreview();hfOpenModal('hf-campaign-modal');}
function hfEditCampaign(id){const c=hfCampaigns.find(x=>x.id===id);if(!c)return;hfEditId=id;document.getElementById('hf-c-name').value=c.name;document.getElementById('hf-c-desc').value=c.description||'';document.getElementById('hf-c-start').value=c.start_date||'';document.getElementById('hf-c-end').value=c.end_date||'';document.getElementById('hf-c-pts').value=c.points_per_checkin;document.getElementById('hf-c-emoji').value=c.emoji||'';document.getElementById('hf-c-freq').value=c.frequency;document.querySelectorAll('.hf-dbtn').forEach(b=>b.classList.remove('on'));const cdw=document.getElementById('hf-custom-days');if(c.frequency==='custom'&&Array.isArray(c.custom_days)){cdw.style.display='block';c.custom_days.forEach(d=>{const btn=document.querySelector(`.hf-dbtn[data-d="${d}"]`);if(btn)btn.classList.add('on');});}else{cdw.style.display='none';}document.getElementById('hf-cm-title').textContent='Edit Campaign';document.getElementById('hf-cm-save').textContent='Save Changes';hfUpdateTierPreview();hfOpenModal('hf-campaign-modal');}
async function hfSaveCampaign(){if(!hfSb){hfToast('Connect Supabase first via Settings.','er');return;}const name=document.getElementById('hf-c-name').value.trim();const desc=document.getElementById('hf-c-desc').value.trim();const start=document.getElementById('hf-c-start').value||hfDateStr();const end=document.getElementById('hf-c-end').value||null;const pts=parseInt(document.getElementById('hf-c-pts').value)||10;const emoji=document.getElementById('hf-c-emoji').value.trim()||'📌';const freq=document.getElementById('hf-c-freq').value;if(!name){hfToast('Campaign name is required.','er');return;}let customDays=null;if(freq==='custom'){customDays=[...document.querySelectorAll('.hf-dbtn.on')].map(b=>+b.dataset.d);if(!customDays.length){hfToast('Select at least one day.','er');return;}}const payload={name,description:desc,start_date:start,end_date:end,points_per_checkin:pts,emoji,frequency:freq,custom_days:customDays};if(hfEditId){const{error}=await hfSb.from('hf_campaigns').update(payload).eq('id',hfEditId);if(error){hfToast(error.message,'er');return;}const i=hfCampaigns.findIndex(x=>x.id===hfEditId);if(i!==-1)hfCampaigns[i]={...hfCampaigns[i],...payload};hfToast('Campaign updated! ✓','ok');}else{const{data,error}=await hfSb.from('hf_campaigns').insert({...payload,is_active:true}).select().single();if(error){hfToast(error.message,'er');return;}hfCampaigns.unshift(data);hfToast(`Campaign "${name}" created!`,'ok');}hfCloseModal('hf-campaign-modal');hfRenderAll();}
function hfClearCampForm(){['hf-c-name','hf-c-desc','hf-c-start','hf-c-end','hf-c-emoji'].forEach(id=>document.getElementById(id).value='');document.getElementById('hf-c-pts').value='10';document.getElementById('hf-c-freq').value='daily';document.getElementById('hf-custom-days').style.display='none';document.querySelectorAll('.hf-dbtn').forEach(b=>b.classList.remove('on'));}
function hfFreqChange(){document.getElementById('hf-custom-days').style.display=document.getElementById('hf-c-freq').value==='custom'?'block':'none';}
async function hfToggleCamp(id,active){if(!hfSb)return;await hfSb.from('hf_campaigns').update({is_active:active}).eq('id',id);const c=hfCampaigns.find(x=>x.id===id);if(c)c.is_active=active;hfRenderCampaigns();hfRenderDashboard();hfRenderCheckin();hfToast(active?'Campaign reactivated!':'Campaign archived.','in');}
async function hfDeleteCamp(id){if(!hfSb||!confirm('Delete this campaign and all its check-ins?'))return;await hfSb.from('hf_checkins').delete().eq('campaign_id',id);await hfSb.from('hf_campaigns').delete().eq('id',id);hfCampaigns=hfCampaigns.filter(c=>c.id!==id);hfCheckins=hfCheckins.filter(ci=>ci.campaign_id!==id);hfRenderCampaigns();hfRenderDashboard();hfRenderCheckin();hfToast('Campaign deleted.','in');}
function hfRenderCampaigns(){const el=document.getElementById('hf-camp-grid');if(!hfCampaigns.length){el.innerHTML=`<div class="hf-empty" style="grid-column:1/-1">No campaigns yet!</div>`;return;}el.innerHTML=hfCampaigns.map(c=>{const s=hfCalcStreak(c.id),total=hfCheckins.filter(ci=>ci.campaign_id===c.id).length,prog=c.end_date?hfCalcProg(c):null;const fl={daily:'Every day',weekdays:'Weekdays',weekends:'Weekends',custom:'Custom'}[c.frequency]||c.frequency;return`<div class="hf-ccard" onclick="hfEditCampaign('${c.id}')"><div class="hf-ccard-top"><div class="hf-ccard-emo">${c.emoji||'📌'}</div><div class="hf-ccard-badges"><div class="hf-cstatus ${c.is_active?'hf-cs-on':'hf-cs-off'}">${c.is_active?'Active':'Ended'}</div><div class="hf-edit-hint">✏ edit</div></div></div><div class="hf-ccard-name">${hfEsc(c.name)}</div><div class="hf-ccard-desc">${hfEsc(c.description||'')}</div>${prog!==null?`<div class="hf-pbar"><div class="hf-pfill" style="width:${prog}%"></div></div>`:''}<div class="hf-cmeta"><div><div class="hf-cm-l">Streak</div><div class="hf-cm-v">🔥 ${s} days</div></div><div><div class="hf-cm-l">Check-ins</div><div class="hf-cm-v">${total}</div></div><div><div class="hf-cm-l">Base pts/day</div><div class="hf-cm-v">${c.points_per_checkin}</div></div><div><div class="hf-cm-l">Schedule</div><div class="hf-cm-v">${fl}</div></div></div><div class="hf-ccard-acts" onclick="event.stopPropagation()">${c.is_active?`<button class="hf-btn-muted" onclick="hfToggleCamp('${c.id}',false)">Archive</button>`:`<button class="hf-btn-muted" onclick="hfToggleCamp('${c.id}',true)">Reactivate</button>`}<button class="hf-btn-danger" onclick="hfDeleteCamp('${c.id}')">Delete</button></div></div>`;}).join('');}
function hfRenderCheckin(){const el=document.getElementById('hf-ci-list'),today=hfDateStr(),due=hfCampaigns.filter(c=>c.is_active&&hfIsDue(c));if(!due.length){el.innerHTML=`<div class="hf-empty">No habits due today 😴</div>`;return;}el.innerHTML=due.map(c=>{const s=hfCalcStreak(c.id),tier=hfGetTier(s),pts=hfTierPts(c.points_per_checkin,s),done=hfCheckins.some(ci=>ci.campaign_id===c.id&&ci.checked_date===today);return`<div class="hf-ciitem${done?' done':''}"><div class="hf-ci-emo">${c.emoji||'📌'}</div><div class="hf-ci-info"><div class="hf-ci-name">${hfEsc(c.name)}</div><div class="hf-ci-streak">🔥 ${s} day streak &nbsp;<span class="hf-tbadge hf-t-${tier.cls}">${tier.label}</span></div><div class="hf-ci-pts">+${pts} pts today <span class="hf-pts-base">(${c.points_per_checkin}×${tier.mult})</span></div></div><div class="hf-ci-act">${done?`<button class="hf-btn-ghost" disabled style="opacity:.5;cursor:default">✓ Done</button>`:`<button class="hf-btn-green" onclick="hfCheckin('${c.id}')">Check In</button>`}</div></div>`;}).join('');}
async function hfCheckin(campaignId){if(!hfSb){hfToast('Connect Supabase first.','er');return;}const today=hfDateStr();if(hfCheckins.some(ci=>ci.campaign_id===campaignId&&ci.checked_date===today)){hfToast('Already checked in today!','in');return;}const camp=hfCampaigns.find(c=>c.id===campaignId);if(!camp)return;const{data,error}=await hfSb.from('hf_checkins').insert({campaign_id:campaignId,checked_date:today}).select().single();if(error){hfToast(error.message,'er');return;}hfCheckins.unshift(data);const s=hfCalcStreak(campaignId),tier=hfGetTier(s),pts=hfTierPts(camp.points_per_checkin,s);hfTotalPts+=pts;await hfSb.from('hf_settings').update({total_points:hfTotalPts}).eq('id','user');hfUpdatePts();hfRenderDashboard();hfRenderCheckin();hfToast(`✓ Checked in! +${pts} pts${tier.mult>1?` (${tier.label} ${tier.mult}× 🚀)`:''}`,'ok');renderDashEventBanner();await hfCheckMilestones(campaignId);}
async function hfCheckMilestones(campaignId){const s=hfCalcStreak(campaignId),total=hfCheckins.filter(ci=>ci.campaign_id===campaignId).length;for(const r of hfRewards){if(r.campaign_id&&r.campaign_id!==campaignId)continue;if(r._earned.length>0&&!r.is_repeatable)continue;let met=false;if(r.trigger_type==='streak'&&s>=r.trigger_value)met=true;if(r.trigger_type==='total'&&total>=r.trigger_value)met=true;if(r.trigger_type==='points'&&hfTotalPts>=r.trigger_value)met=true;if(!met)continue;const{data}=await hfSb.from('hf_earned').insert({reward_id:r.id}).select().single();r._earned.push(data);if(r.bonus_points>0){hfTotalPts+=r.bonus_points;await hfSb.from('hf_settings').update({total_points:hfTotalPts}).eq('id','user');hfUpdatePts();}hfToast(`🎉 Reward unlocked: "${r.name}"! +${r.bonus_points} pts`,'ok');hfRenderRewards();hfRenderDashboard();renderDashEventBanner();}}
function hfRenderRewards(){document.getElementById('hf-r-camp').innerHTML='<option value="">Any campaign</option>'+hfCampaigns.map(c=>`<option value="${c.id}">${hfEsc(c.name)}</option>`).join('');const el=document.getElementById('hf-reward-grid');if(!hfRewards.length){el.innerHTML=`<div class="hf-empty" style="grid-column:1/-1">No rewards yet!</div>`;return;}el.innerHTML=hfRewards.map(r=>{const earned=r._earned&&r._earned.length>0,camp=hfCampaigns.find(c=>c.id===r.campaign_id);const tl={streak:`${r.trigger_value}-day streak`,total:`${r.trigger_value} check-ins`,points:`${r.trigger_value} pts`}[r.trigger_type];return`<div class="hf-rcard${earned?' earned':''}"><button class="hf-btn-danger hf-rdel" onclick="hfDeleteReward('${r.id}')">✕</button><div class="hf-rcard-emo">${r.emoji||'🏆'}</div><div class="hf-rcard-name">${hfEsc(r.name)}</div><div class="hf-rcard-desc">${hfEsc(r.description||'')}</div><div class="hf-rtags"><span class="hf-rtag">🎯 ${tl}</span><span class="hf-rtag hf-rtag-bonus">+${r.bonus_points} pts</span>${r.is_repeatable?'<span class="hf-rtag">🔁</span>':''}${camp?`<span class="hf-rtag">📌 ${hfEsc(camp.name)}</span>`:''}${earned?'<span class="hf-rtag hf-rtag-earned">✓ Earned</span>':''}</div></div>`;}).join('');}
async function hfSaveReward(){if(!hfSb){hfToast('Connect Supabase first.','er');return;}const name=document.getElementById('hf-r-name').value.trim();const desc=document.getElementById('hf-r-desc').value.trim();const campId=document.getElementById('hf-r-camp').value||null;const ttype=document.getElementById('hf-r-ttype').value;const tval=parseInt(document.getElementById('hf-r-tval').value)||7;const bonus=parseInt(document.getElementById('hf-r-bonus').value)||50;const emoji=document.getElementById('hf-r-emoji').value.trim()||'🏆';const repeat=document.getElementById('hf-r-repeat').value==='true';if(!name){hfToast('Reward name is required.','er');return;}const{data,error}=await hfSb.from('hf_rewards').insert({name,description:desc,campaign_id:campId,trigger_type:ttype,trigger_value:tval,bonus_points:bonus,emoji,is_repeatable:repeat}).select().single();if(error){hfToast(error.message,'er');return;}data._earned=[];hfRewards.push(data);hfCloseModal('hf-reward-modal');['hf-r-name','hf-r-desc','hf-r-emoji'].forEach(id=>document.getElementById(id).value='');document.getElementById('hf-r-tval').value='7';document.getElementById('hf-r-bonus').value='50';hfRenderRewards();hfToast(`Reward "${name}" created!`,'ok');}
async function hfDeleteReward(id){if(!hfSb||!confirm('Delete this reward?'))return;await hfSb.from('hf_earned').delete().eq('reward_id',id);await hfSb.from('hf_rewards').delete().eq('id',id);hfRewards=hfRewards.filter(r=>r.id!==id);hfRenderRewards();hfToast('Reward deleted.','in');}
function hfOpenModal(id){document.getElementById(id).classList.add('on');}
function hfCloseModal(id){document.getElementById(id).classList.remove('on');if(id==='hf-campaign-modal'){hfEditId=null;hfClearCampForm();}}
function hfBgClose(e,id){if(e.target===document.getElementById(id))hfCloseModal(id);}
let _hfTT;
function hfToast(msg,type='in'){const el=document.getElementById('hf-toast');el.textContent=msg;el.className=`hf-toast show ${type}`;clearTimeout(_hfTT);_hfTT=setTimeout(()=>el.classList.remove('show'),3800);}
document.querySelectorAll('.hf-dbtn').forEach(b=>b.addEventListener('click',()=>b.classList.toggle('on')));

/* ════ LOTTO ORACLE ════ */
const loTable='draws';let loAllDraws=[];let loChart=null;
function loSetStatus(ok){const p=document.getElementById('lo-dbPulse');const s=document.getElementById('lo-dbStatus');if(p)p.className='lo-pulse'+(ok?'':' red');if(s)s.textContent=ok?'SUPABASE LIVE':'NOT CONNECTED — set up Supabase in Spendly';}
async function loLoadData(){if(!spClient){loSetStatus(false);loRender();return;}loSetStatus(true);const hw=document.getElementById('lo-historyWrap');if(hw)hw.innerHTML='<div class="lo-loading"><div class="lo-spinner"></div><div class="lo-loading-txt">FETCHING…</div></div>';const{data,error}=await spClient.from(loTable).select('*').order('draw_date',{ascending:false});if(error){loToast('FETCH ERROR: '+error.message,true);loSetStatus(false);return;}loAllDraws=(data||[]).map(row=>({id:row.id,date:row.draw_date,numbers:[row.n1,row.n2,row.n3,row.n4,row.n5,row.n6].map(Number).sort((a,b)=>a-b)}));const lu=document.getElementById('lo-lastUpdate');if(lu)lu.textContent='LAST SYNC: '+new Date().toLocaleTimeString();loRender();}
async function loAddDraw(){if(!spClient){loToast('NO SUPABASE CONNECTION',true);return;}const inputs=[...document.querySelectorAll('.lo-draw-num')].map(i=>parseInt(i.value));const date=document.getElementById('lo-drawDate').value;if(inputs.some(n=>isNaN(n)||n<1||n>49)){loToast('ENTER 6 VALID NUMBERS (1–49)',true);return;}if(new Set(inputs).size!==6){loToast('NUMBERS MUST BE UNIQUE',true);return;}if(!date){loToast('ENTER DRAW DATE',true);return;}const sorted=inputs.sort((a,b)=>a-b);const{error}=await spClient.from(loTable).insert({draw_date:date,n1:sorted[0],n2:sorted[1],n3:sorted[2],n4:sorted[3],n5:sorted[4],n6:sorted[5]});if(error){loToast('INSERT ERROR: '+error.message,true);return;}document.querySelectorAll('.lo-draw-num').forEach(i=>i.value='');document.getElementById('lo-drawDate').value='';loToast('DRAW LOGGED ✓');loLoadData();}
async function loDeleteDraw(id){if(!spClient||!confirm('Delete this draw?'))return;const{error}=await spClient.from(loTable).delete().eq('id',id);if(error){loToast('DELETE ERROR: '+error.message,true);return;}loToast('DRAW REMOVED');loLoadData();}
function loBuildFrequencyMap(){const freq={};for(let n=1;n<=49;n++)freq[n]=0;loAllDraws.forEach(d=>d.numbers.forEach(n=>freq[n]++));return freq;}
function loBuildPairMatrix(){const m={};for(let i=1;i<=49;i++){m[i]={};for(let j=1;j<=49;j++)m[i][j]=0;}loAllDraws.forEach(d=>{const ns=d.numbers;for(let i=0;i<ns.length;i++)for(let j=i+1;j<ns.length;j++){m[ns[i]][ns[j]]++;m[ns[j]][ns[i]]++;}});return m;}
function loGeneratePredictions(){if(loAllDraws.length<2)return[];const total=loAllDraws.length;const freq=loBuildFrequencyMap();const pairs=loBuildPairMatrix();const expected=total*6/49;const setA=Object.entries(freq).sort((a,b)=>b[1]-a[1]).slice(0,6).map(e=>+e[0]);const setB=Object.entries(freq).map(([n,f])=>({n:+n,due:expected-f})).sort((a,b)=>b.due-a.due).slice(0,6).map(e=>e.n);const setC=[setA[0]];const pairScore=n=>setC.reduce((s,x)=>s+pairs[x][n],0);while(setC.length<6){const cands=Array.from({length:49},(_,i)=>i+1).filter(n=>!setC.includes(n));cands.sort((a,b)=>pairScore(b)-pairScore(a));setC.push(cands[0]);}const maxFreq=Math.max(...Object.values(freq));const setD=Array.from({length:49},(_,i)=>i+1).map(n=>({n,score:(freq[n]/(maxFreq||1))*0.5+(1-(freq[n]/(expected*2||1)))*0.3+(Object.values(pairs[n]).reduce((s,v)=>s+v,0)/(Object.values(pairs[n]).length*(maxFreq||1)))*0.2})).sort((a,b)=>b.score-a.score).slice(0,6).map(e=>e.n);const rw=Math.min(10,total);const rFreq={};for(let n=1;n<=49;n++)rFreq[n]=0;loAllDraws.slice(0,rw).forEach(d=>d.numbers.forEach(n=>rFreq[n]++));const setE=Array.from({length:49},(_,i)=>i+1).filter(n=>freq[n]<expected).map(n=>({n,surge:rFreq[n]/(freq[n]||0.01)})).sort((a,b)=>b.surge-a.surge).slice(0,6).map(e=>e.n);return[{label:'SET A',tag:'FREQUENCY BOOST',balls:setA.sort((a,b)=>a-b),style:'gold',confidence:72},{label:'SET B',tag:'DUE NUMBERS',balls:setB.sort((a,b)=>a-b),style:'cyan',confidence:68},{label:'SET C',tag:'PAIR CORRELATION',balls:setC.sort((a,b)=>a-b),style:'orange',confidence:65},{label:'SET D',tag:'WEIGHTED HYBRID',balls:setD.sort((a,b)=>a-b),style:'green',confidence:78},{label:'SET E',tag:'COLD SURGE',balls:setE.sort((a,b)=>a-b),style:'white',confidence:60}];}
function loRender(){loRenderStats();loRenderPredictions();loRenderHotGrid();loRenderChart();loRenderHistory();}
function loRenderStats(){const freq=loBuildFrequencyMap();const entries=Object.entries(freq);const hot=entries.slice().sort((a,b)=>b[1]-a[1])[0];const cold=entries.slice().sort((a,b)=>a[1]-b[1])[0];const sd=document.getElementById('lo-statDraws');if(sd)sd.textContent=loAllDraws.length||'—';const sh=document.getElementById('lo-statHot');if(sh)sh.textContent=loAllDraws.length?hot[0]:'—';const sc=document.getElementById('lo-statCold');if(sc)sc.textContent=loAllDraws.length?cold[0]:'—';}
function loRenderPredictions(){const preds=loGeneratePredictions();const wrap=document.getElementById('lo-predictionSets');if(!wrap)return;if(!preds.length){wrap.innerHTML='<div class="lo-empty">NEED ≥2 DRAWS FOR PREDICTIONS</div>';return;}wrap.innerHTML=preds.map(p=>`<div class="lo-pred-row"><div class="lo-pred-rank">${p.label}</div><div class="lo-pred-balls">${p.balls.map(n=>`<div class="lo-ball ${p.style}">${String(n).padStart(2,'0')}</div>`).join('')}</div><div class="lo-pred-score"><span>${p.confidence}%</span>${p.tag}</div></div>`).join('');}
function loRenderHotGrid(){const freq=loBuildFrequencyMap();const max=Math.max(...Object.values(freq));const top14=Object.entries(freq).sort((a,b)=>b[1]-a[1]).slice(0,14).map(e=>+e[0]);const grid=document.getElementById('lo-hotGrid');if(!grid)return;if(!loAllDraws.length){grid.innerHTML='<div class="lo-empty" style="grid-column:1/-1">NO DATA YET</div>';return;}grid.innerHTML=top14.map((n,i)=>{const pct=max?freq[n]/max*100:0;const cls=i===0?'lhot1':i<3?'lhot2':'lhot3';return`<div class="lo-hot-cell ${cls}"><span class="lo-hot-num">${n}</span><div class="lo-hot-bar" style="width:${pct}%"></div><span class="lo-hot-cnt">${freq[n]}×</span></div>`;}).join('');}
function loRenderChart(){const canvas=document.getElementById('lo-freqChart');if(!canvas)return;const ctx=canvas.getContext('2d');if(loChart){loChart.destroy();loChart=null;}const freq=loBuildFrequencyMap();const sorted=Object.entries(freq).sort((a,b)=>b[1]-a[1]).slice(0,15);if(!sorted.some(e=>e[1]>0))return;const labels=sorted.map(e=>e[0]);const values=sorted.map(e=>e[1]);const isDark=document.documentElement.getAttribute('data-theme')==='dark';const gc=isDark?'rgba(30,45,61,0.5)':'rgba(140,110,70,0.1)';const tc=isDark?'#4a5568':'#a8947a';loChart=new Chart(ctx,{type:'bar',data:{labels,datasets:[{data:values,backgroundColor:labels.map((_,i)=>i===0?'rgba(255,215,0,0.7)':i<3?'rgba(0,229,255,0.6)':i<6?'rgba(255,107,53,0.5)':'rgba(168,255,62,0.3)'),borderColor:labels.map((_,i)=>i===0?'#ffd700':i<3?'#00e5ff':i<6?'#ff6b35':'#a8ff3e'),borderWidth:1,borderRadius:4}]},options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{x:{ticks:{color:tc,font:{size:10}},grid:{color:gc}},y:{ticks:{color:tc,font:{size:10}},grid:{color:gc}}}}});}
function loRenderHistory(){const wrap=document.getElementById('lo-historyWrap');if(!wrap)return;if(!loAllDraws.length){wrap.innerHTML='<div class="lo-empty">NO DRAWS LOGGED YET</div>';return;}wrap.innerHTML=`<table class="lo-history-table"><thead><tr><th>#</th><th>DATE</th><th>NUMBERS</th><th>DEL</th></tr></thead><tbody>${loAllDraws.map((d,i)=>`<tr><td>${loAllDraws.length-i}</td><td>${d.date||'—'}</td><td>${d.numbers.map(n=>`<span class="lo-mini-ball">${n}</span>`).join('')}</td><td><button class="lo-del-btn" onclick="loDeleteDraw('${d.id}')">✕</button></td></tr>`).join('')}</tbody></table>`;}
function loToast(msg,err=false){const el=document.getElementById('lo-toast');if(!el)return;el.textContent=msg;el.className='show'+(err?' lo-err':'');clearTimeout(loToast._t);loToast._t=setTimeout(()=>el.className='',3000);}

/* ════ BOOT ════ */
loadS();loadCachedTxns();applyTheme();updateSbSettingsCard();
document.getElementById('add-btn').style.display='none';

if(S.supabaseUrl&&S.supabaseKey){
  const{createClient}=supabase;
  spClient=createClient(S.supabaseUrl,S.supabaseKey);
  hfInitWithClient(spClient);
  go('dashboard');fetchTxns();
}else{go('setup');}

(async()=>{
  if(clSbConfig){try{clSbClient=await initClSupabase(clSbConfig.url,clSbConfig.key);updateSbIndicator(true,clSbConfig.url);await loadEventsFromSupabase();}catch(e){updateSbIndicator(false);renderAll();renderDashEventBanner();}}
  else{renderAll();renderDashEventBanner();}
})();

(function loInit(){const dd=document.getElementById('lo-drawDate');if(dd)dd.value=new Date().toISOString().split('T')[0];if(spClient){loLoadData();}else{loSetStatus(false);loRender();}})();

const hash=location.hash;if(hash.startsWith('#event=')){const id=hash.slice(7);if(events.find(e=>e.id===id))openDetail(id);}
</script>
</body>
</html>
