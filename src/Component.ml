module StatefulRP = struct

    module type Intf = sig
        type state
        type action
        type retainedProps
    end

    module type S = sig
        include Intf
        type t = (state, retainedProps, action) ReasonReact.self
    end

    module Make(M: Intf) = struct
        type t = (M.state, M.retainedProps, M.action) ReasonReact.self
    end
end

module Stateful = struct

    module type Intf = StatefulRP.Intf 
        with type retainedProps := ReasonReact.noRetainedProps
    
    module Make(M: Intf) = struct
        module S = struct
            include M
            type retainedProps = ReasonReact.noRetainedProps
        end

        include StatefulRP.Make(S)
    end

end
