mod common;
mod engine;
mod languages;
mod provider;

pub use beyondtranslate_core::{
    DictionaryError, DictionaryService, OcrError, OcrService, Provider, TranslationError,
    TranslationService,
};
pub use engine::{
    from_yaml_str, load_from_file, Engine, EngineConfig, EngineError, ProviderConfig, ProviderType,
};
pub use languages::{all_languages, app_languages};

// LLM providers (primary).
pub use provider::{
    prompt, response, specs, OpenAiCompatibleProvider, OpenAiCompatibleProviderConfig,
    OpenAiCompatibleSpec, OpenAiProviderConfig, XAiProviderConfig,
};

// Traditional providers.
#[cfg(feature = "baidu_fanyi_api")]
pub use provider::traditional::BaiduFanyiApiProvider;
#[cfg(feature = "caiyun_platform")]
pub use provider::traditional::CaiyunPlatformProvider;
pub use provider::traditional::DeepLApiProvider;
#[cfg(feature = "google_cloud")]
pub use provider::traditional::GoogleCloudProvider;
pub use provider::traditional::SystemProvider;
pub use provider::traditional::SystemTranslationService;
#[cfg(feature = "tencent_cloud")]
pub use provider::traditional::TencentCloudProvider;
#[cfg(feature = "youdao_zhiyun")]
pub use provider::traditional::YoudaoZhiyunProvider;
pub use provider::traditional::{
    AlibabaCloudProvider, AlibabaCloudProviderConfig, BaiduFanyiApiProviderConfig,
    CaiyunPlatformProviderConfig, DeepLApiProviderConfig, GoogleCloudProviderConfig,
    MicrosoftAzureProvider, MicrosoftAzureProviderConfig, NiutransProvider, NiutransProviderConfig,
    TencentCloudProviderConfig, VolcengineProvider, VolcengineProviderConfig, YandexCloudProvider,
    YandexCloudProviderConfig, YoudaoZhiyunProviderConfig,
};

#[cfg(test)]
mod tests;
