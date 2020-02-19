package com.iamuse.webview_plugin;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Point;
import android.os.Build;
import android.text.TextUtils;
import android.view.Display;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;


public class WebviewPlugin implements MethodChannel.MethodCallHandler {
  private Activity activity;
  private WebView webView;
  private MethodChannel.Result result;
  /** 视频全屏参数 */
  protected static final FrameLayout.LayoutParams COVER_SCREEN_PARAMS = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
  private View customView;
  private FrameLayout fullscreenContainer;
  private WebChromeClient.CustomViewCallback customViewCallback;
  /**
   * Plugin registration.
   */
  public static void registerWith(PluginRegistry.Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "webview_plugin");
    channel.setMethodCallHandler(new WebviewPlugin(registrar.activity()));
  }

  @TargetApi(Build.VERSION_CODES.ECLAIR_MR1)
  public WebviewPlugin(Activity activity) {
    this.activity = activity;
    webView=new WebView(activity);
    webView.getSettings().setJavaScriptEnabled(true);
    webView.getSettings().setLoadWithOverviewMode(true);
    webView.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
    webView.getSettings().setLoadsImagesAutomatically(true);// 加载网页中的图片
    webView.getSettings().setUseWideViewPort(true); //设置使用视图的宽端口
    webView.getSettings().setAllowFileAccess(true);// 可以读取文件缓存(manifest生效)
    webView.getSettings().setSupportZoom(true); // 支持缩放

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      webView.getSettings().setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
    }
  }

  @Override
  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
    this.result=result;
    switch (call.method) {
      case "load":
        FrameLayout.LayoutParams params = buildLayoutParams(call);
        LinearLayout linearLayout = new LinearLayout(activity);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        final TextView titleView=new TextView(activity);
        titleView.setSingleLine(true);
        titleView.setEllipsize(TextUtils.TruncateAt.END);
        titleView.setTextColor(Color.parseColor("#FFFFFF"));
        titleView.setPadding(dp2px(activity,10),dp2px(activity,20),dp2px(activity,10),0);
        ViewGroup.LayoutParams titleViewParams= new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT);
        titleView.setLayoutParams(titleViewParams);
        titleView.setText("我是标题");
        titleView.setGravity(Gravity.CENTER);
        ViewGroup.LayoutParams layoutParams= new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,dp2px(activity,70));
        titleView.setLayoutParams(layoutParams);
        titleView.setBackgroundColor(Color.parseColor("#4876FF"));
        linearLayout.addView(titleView);
        linearLayout.addView(webView);
        activity.addContentView(linearLayout, params);
        webView.setWebViewClient(new MyWebViewClient(activity, (title, isError) -> titleView.setText(title)));

        webView.setWebChromeClient(new WebChromeClient() {

          /*** 视频播放相关的方法 **/

          @Override
          public View getVideoLoadingProgressView() {
            FrameLayout frameLayout = new FrameLayout(activity);
            frameLayout.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
            return frameLayout;
          }

          @Override
          public void onShowCustomView(View view, CustomViewCallback callback) {
            showCustomView(view, callback);
          }

          @Override
          public void onHideCustomView() {
            hideCustomView();
          }
          /** 隐藏视频全屏 */
          private void hideCustomView() {
            if (customView == null) {
              return;
            }

            setStatusBarVisibility(true);
            FrameLayout decor = (FrameLayout) activity.getWindow().getDecorView();
            decor.removeView(fullscreenContainer);
            fullscreenContainer = null;
            customView = null;
            customViewCallback.onCustomViewHidden();
            webView.setVisibility(View.VISIBLE);
          }
          /** 视频播放全屏 **/
          private void showCustomView(View view, CustomViewCallback callback) {
            // if a view already exists then immediately terminate the new one
            if (customView != null) {
              callback.onCustomViewHidden();
              return;
            }

            activity.getWindow().getDecorView();

            FrameLayout decor = (FrameLayout) activity.getWindow().getDecorView();
            fullscreenContainer = new FullscreenHolder(activity);
            fullscreenContainer.addView(view, COVER_SCREEN_PARAMS);
            decor.addView(fullscreenContainer, COVER_SCREEN_PARAMS);
            customView = view;
            setStatusBarVisibility(false);
            customViewCallback = callback;
          }
          /** 全屏容器界面 */
          class FullscreenHolder extends FrameLayout {

            public FullscreenHolder(Context ctx) {
              super(ctx);
              setBackgroundColor(ctx.getResources().getColor(android.R.color.black));
            }

            @Override
            public boolean onTouchEvent(MotionEvent evt) {
              return true;
            }
          }

          private void setStatusBarVisibility(boolean visible) {
            int flag = visible ? 0 : WindowManager.LayoutParams.FLAG_FULLSCREEN;
            activity.getWindow().setFlags(flag, WindowManager.LayoutParams.FLAG_FULLSCREEN);
          }
        });
        webView.loadUrl(call.argument("url").toString());
    }

  }


  public class MyWebViewClient extends WebViewClient {
    private final WebClientLoadListener loadListener;
    Activity activity;

    private boolean isError;

    public MyWebViewClient(Activity activity, WebClientLoadListener loadListener) {
      this.activity = activity;
      this.loadListener = loadListener;
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
      return super.shouldOverrideUrlLoading(view, url);
    }

    @Override
    public void onPageStarted(WebView view, String url, Bitmap favicon) {
      super.onPageStarted(view, url, favicon);
      isError = false;
    }

    @Override
    public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
      super.onReceivedError(view, request, error);
      isError = true;
    }

    /**
     * 界面加载完后回调
     *
     * @param view
     * @param url
     */
    @Override
    public void onPageFinished(WebView view, String url) {
      String title = view.getTitle(); // 获取网页标题
      loadListener.loadFinished(title, isError);
      super.onPageFinished(view, url);
    }

  }

  public interface WebClientLoadListener {
    void loadFinished(String title, boolean isError);
  }


  @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
  private FrameLayout.LayoutParams buildLayoutParams(MethodCall call) {
    Map<String, Number> rc = call.argument("rect");
    FrameLayout.LayoutParams params;
    if (rc != null) {
      params = new FrameLayout.LayoutParams(
              dp2px(activity, rc.get("width").intValue()), dp2px(activity, rc.get("height").intValue()));
      params.setMargins(dp2px(activity, rc.get("left").intValue()), dp2px(activity, rc.get("top").intValue()),
              0, 0);
    } else {
      Display display = activity.getWindowManager().getDefaultDisplay();
      Point size = new Point();
      display.getSize(size);
      int width = size.x;
      int height = size.y;
      params = new FrameLayout.LayoutParams(width, height);
    }
    return params;
  }

  private int dp2px(Context context, float dp) {
    final float scale = context.getResources().getDisplayMetrics().density;
    return (int) (dp * scale + 0.5f);
  }
}
