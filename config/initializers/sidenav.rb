SIDENAV = [
  {
    id: "app_name",
    type: "image",
    label: "Progenitor",
    url: "/",
    image: "progenitor.png"
  }, {
    id: "dashboard",
    type: "submenu",
    label: "Dashboard",
    icon: "chart-pie",
    subitems: [
      {
        id: "overview",
        label: "Overview",
        url: "/dashboard/overview"
      },
      {
        id: "traffic",
        label: "Traffic & Engagement",
        url: "/dashboard/traffic"
      },
      {
        id: "analysis",
        label: "Product Analysis",
        letter: "A",
        url: "/dashboard/analysis"
      },
      {
        id: "explore",
        label: "Explore",
        url: "/dashboard/explore"
      }
    ]
  }, {
    id: "kanban",
    type: "item",
    label: "Kanban",
    url: "/kanban",
    icon: "th"
  }, {
    id: "messages",
    type: "pill",
    label: "Messages",
    url: "/messages",
    icon: "inbox",
    tag: "messages",
    color: "white",
    background: "danger",
    paths: ["/messages/new"]
  }, {
    id: "customers",
    type: "item",
    label: "Customers",
    url: "/customers",
    icon: "user-check"
  }, {
    id: "transactions",
    type: "item",
    label: "Transactions",
    url: "/transactions",
    icon: "hand-holding-usd"
  }, {
    id: "tasks",
    type: "item",
    label: "Tasks",
    url: "/tasks",
    icon: "clipboard-list"
  }, {
    id: "settings",
    type: "item",
    label: "Settings",
    url: "/settings",
    icon: "cog"
  }, {
    id: "calendar",
    type: "item",
    label: "Calendar",
    url: "/calendar",
    icon: "calendar-alt"
  }, {
    id: "map",
    type: "item",
    label: "Map",
    url: "/map",
    icon: "map-marked-alt"
  }, {
    id: "pages",
    type: "submenu",
    label: "Pages",
    icon: "file-alt",
    subitems: [
      {
        id: "invoice",
        label: "Invoice",
        url: "/pages/invoice"
      },
      {
        id: "sign_in",
        label: "Sign In",
        url: "/pages/sign-in"
      },
      {
        id: "sign_up",
        label: "Sign Up",
        url: "/pages/sign-up"
      },
      {
        id: "forgot_password",
        label: "Forgot Password",
        url: "/pages/forgot-password"
      },
      {
        id: "reset_password",
        label: "Reset Password",
        url: "/pages/reset-password"
      },
      {
        id: "lock",
        label: "Lock",
        url: "/pages/lock"
      },
      {
        id: "error_404",
        label: "404 Not Found",
        url: "/pages/error-404"
      },
      {
        id: "error_500",
        label: "500 Server Error",
        url: "/pages/error-500"
      }
    ]
  }, {
    id: "components",
    type: "submenu",
    label: "Components",
    icon: "box-open",
    subitems: [
      {
        id: "buttons",
        label: "Buttons",
        url: "/components/buttons"
      },
      {
        id: "forms",
        label: "Forms",
        url: "/components/forms"
      },
      {
        id: "modals",
        label: "Modals",
        url: "/components/modals"
      },
      {
        id: "typography",
        label: "Typography",
        url: "/components/typography"
      }
    ]
  }, {
    id: "cards",
    type: "item",
    label: "Cards",
    url: "/cards",
    icon: "th-large"
  }, {
    type: "separator"
  }, {
    id: "documentation",
    type: "pill",
    label: "Documentation",
    url: "/docs",
    icon: "book",
    tag: "version",
    color: "dark",
    background: "secondary"
  }, {
    id: "buy",
    type: "item",
    label: "Buy Now",
    url: "/buy",
    icon: "shopping-cart"
  }, {
    id: "author",
    type: "image",
    label: "leastbad",
    url: "https://leastbad.com",
    image: "gt.svg"
  }
]
