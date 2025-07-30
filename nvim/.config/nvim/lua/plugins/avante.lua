return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  build = "make",
  keys = {
    { "<leader>ac", "<cmd>AvanteChat<cr>", desc = "Avante Chat", mode = { "n", "v" } },
  },
  opts = {
    provider = "claude",
    auto_suggestions_provider = "claude",
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      enable_fastapply = true,  -- Enable Fast Apply feature
    },
    rag_service = {
      enabled = true,
      host_mount = os.getenv("HOME"),
      runner = "docker",
      llm = {
        provider = "openai",
        endpoint = "https://api.openai.com/v1",
        api_key = "OPENAI_API_KEY",
        model = "gpt-4o-mini",  -- Fast and cost-effective for RAG
        extra = {
          temperature = 0.3,  -- Lower for more consistent responses
          max_tokens = 1024,
        },
      },
      embed = {
        provider = "openai",
        endpoint = "https://api.openai.com/v1",
        api_key = "OPENAI_API_KEY",
        model = "text-embedding-3-large",  -- Best embedding model
        extra = {
          dimensions = nil,  -- Use default dimensions
        },
      },
      docker_extra_args = "",
    },
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right",
      wrap = true,
      width = 30,
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
    },
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 8192,
        },
      },
      morph = {
        endpoint = "https://api.morph.so/v1",
        model = "morph-v3-large",  -- 98% accuracy, 2500+ tok/sec
        api_key_name = "MORPH_API_KEY",
        timeout = 30000,
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash-exp",
        api_key_name = "GEMINI_API_KEY",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          maxOutputTokens = 8192,
        },
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_completion_tokens = 8192,
        },
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.app/openai/v1/",
        model = "llama-3.3-70b-versatile",
        extra_request_body = {
          max_completion_tokens = 32768,
        },
      },
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
