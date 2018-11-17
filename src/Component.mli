(** Interface and functor for making types for reducer components
 * Currently, this is really only useful for automatically adding
 * a type t which is the proper ReasonReact.self type for the component
 *)
module StatefulRP : sig

    module type Intf = sig
        type state
        type action
        type retainedProps
    end

    module type S = sig
        include Intf
        type t = (state, retainedProps, action) ReasonReact.self
    end

    module Make(M: Intf): S 
        with type state := M.state
        with type action := M.action
        with type retainedProps := M.retainedProps
end


(** Same as StatefulRP, but with retainedProps assumed to be
 * ReasonReact.noRetainedProps
 *)
module Stateful : sig

    module type Intf = StatefulRP.Intf 
        with type retainedProps := ReasonReact.noRetainedProps

    module Make(M: Intf): StatefulRP.S
        with type state := M.state
        with type action := M.action
        with type retainedProps := ReasonReact.noRetainedProps

end
