Shader "Custom/ProgressBar" {
	Properties {
		_MainTex ("Mask Texture", 2D) = "white" {}
		_Tex2("MainTexture ", 2D) = "white"{}
		_Tex3("BG Texture ", 2D) = "white"{}
		_Progress("Progress", Range(0,1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Transparent" }
		
		CGPROGRAM
		#pragma surface surf Lambert noambient noforwardadd novertexlights nolightmap nodirlightmap

		sampler2D _MainTex;
		sampler2D _Tex2;
		sampler2D _Tex3;
		float _Progress;
		struct Input {
			float2 uv_MainTex;
			float2 uv_Tex2;
			float2 uv_Tex3;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x-(_Progress-0.5), IN.uv_MainTex.y));
			fixed4 d = tex2D (_Tex2, IN.uv_Tex2);
			fixed4 e = tex2D(_Tex3, IN.uv_Tex2);
			o.Emission = d.rgb * (1 - c.r) + e.rgb * c.r;
			//o.Emission = d.rgb * (1-c.r);//lerp(d.rgb, d.rgb, c.r);
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
